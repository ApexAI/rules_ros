#! /usr/bin/env python3
# Copyright 2024 Apex.AI, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import argparse
import tempfile
import yaml
import subprocess
import os
import hashlib
from pathlib import Path
from generate_ros2_config import print_setup_file

REPO_TYPES = ["git", "tar"]

def main():
    parser = argparse.ArgumentParser(description='Generate a Bazel setup file containing repo '
        'rules to load every repository for a given repos file.')
    parser.add_argument('repos', type=str, help='Input YAML *.repos file')
    parser.add_argument('setup_bzl', type=str, help='Output Bazel setup file with repo rules.')
    parser.add_argument('overlays', type=str, nargs='*', help='Additional YAML files are used as '
        'overlays for *.repos file, e.g., to declare BUILD files for a repo.')
    parser.add_argument('--tar', action='store_true', help='Use the GitHub archive download.')

    args = parser.parse_args()
    print(f"Using {args.repos} to generate {args.setup_bzl}")

    with open(args.repos, "r") as repos_file:
        repos = yaml.safe_load(repos_file)

    if repos.get("repositories") is None:
        raise ValueError("No repositories attribute found")

    for repo, spec in repos["repositories"].items():
        if not spec["type"] in REPO_TYPES:
            raise ValueError(f"Repo type {spec['type']} not supported. Need one of {REPO_TYPES} instead.")
        additional_attributes = fetch_dependency_details(use_tar = args.tar, **spec)
        add_attributes(repos["repositories"][repo], additional_attributes)
        print("{}: {}".format(repo, [*additional_attributes.values()]))

    with open(args.setup_bzl, mode='w', encoding='utf8') as setup_bzl:
        print_setup_file(repos = repos["repositories"],
                         yaml_files=args.overlays,
                         output_file=setup_bzl,
                         repos_file = args.repos,
                         use_tar=args.tar)


def fetch_dependency_details(*, use_tar, type, **kwargs):
    if type == "tar" or use_tar:
        return fetch_http_details(type = type, **kwargs)
    return fetch_git_details(type = type, **kwargs)

def add_attributes(dictionary, additional_attributes):
    for k,v in additional_attributes.items():
        dictionary[k] = v

def fetch_http_details(*, type, version = None, url = None, **kwargs):
    forward_type = "http_archive"
    if "sha256" in kwargs:
        return { "type": forward_type}
    with tempfile.TemporaryDirectory() as tempdir:
        archive_filename = Path(tempdir) / "archive.tar.gz"
        if type == "git":
            url = url.rsplit(".git", 1)[0]
            url += f"/archive/refs/tags/{version}.tar.gz"
        result = subprocess.run(
            ["curl", "-L", "-f", "-o", archive_filename, url],
            stdout=subprocess.PIPE,
            encoding='utf8'
        )
        if result.returncode != 0:
            raise ValueError(f"Error loading {url}, {version}: " + (result.stderr or ""))

        archive_bytes = archive_filename.read_bytes()
        hash = hashlib.sha256(archive_bytes).hexdigest()
        strip_prefix = extract_archive_root_folder(archive_filename, url)

    return {
        "hash":hash,
        "url": url,
        "strip_prefix": strip_prefix,
        "type": forward_type,
    }

def extract_archive_root_folder(path, origin):
    result = subprocess.run(
        ["tar", "-tf", path],
        capture_output = True,
        encoding='utf8'
    )
    if result.returncode != 0:
        raise ValueError(f"Not able to read archive from {origin}: " + result.stderr)
    return result.stdout.split('\n')[0].split('/')[0]


def fetch_git_details(url, version, **kwargs):
    cwd = os.getcwd()
    max_retries = 4
    for i in range(max_retries + 1):
        with tempfile.TemporaryDirectory() as tempdir:
            try:
                result = subprocess.run(
                    ["git", "clone", url, "--no-checkout", tempdir, "--depth", "1",
                    "--branch", version, "--bare", "-q"],
                    capture_output = True,
                    encoding='utf8',
                    timeout=5
                )
                if result.returncode != 0:
                    if max_retries == i:
                        raise ValueError(result.stderr)
                    else:
                        print(f"git clone returncode failure. Retrying attempt {i+1}/{max_retries}")
                        continue
                os.chdir(tempdir)
                result = subprocess.run(
                    ["git", "log", "--date=raw", "--format=format:%H/%cd"],
                    stdout=subprocess.PIPE,
                    encoding='utf8',
                    timeout=5
                )
                if result.returncode != 0:
                    if max_retries == i:
                        raise ValueError(result.stderr)
                    else:
                        print(f"git log returncode failure. Retrying attempt {i+1}/{max_retries}")
                        continue
            except subprocess.TimeoutExpired as e:
                if max_retries == i:
                    raise e
                else:
                    print(f"subprocess.TimeoutExpired failure. Retrying attempt {i+1}/{max_retries}")
                    continue

            commit_hash, time = result.stdout.split("/")
            os.chdir(cwd)
            break
    return {
        "hash":commit_hash,
        "shallow_since": time,
    }


if __name__ == "__main__":
    main()
