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

REPO_TYPES = ["git", "tar"]

def main():
    parser = argparse.ArgumentParser(description="Generate a lock file for a given repos file.")
    parser.add_argument('repos', type=str, help='Input YAML file')
    parser.add_argument('lock', type=str, help='Output YAML file with pinned repos')
    parser.add_argument('--tar', action='store_true', help='Use the Github archive download.')

    args = parser.parse_args()
    print(f"Calling {args.repos} {args.lock}")

    with open(args.repos, "r") as repos_file:
        repos = yaml.safe_load(repos_file)

    if repos.get("repositories") is None:
        raise ValueError("No repositories attribute found")

    for repo, spec in repos["repositories"].items():
        if not spec["type"] in REPO_TYPES:
            raise ValueError(f"Repo type {spec['type']} not supported. Need one of {REPO_TYPES} instead.")
        if args.tar:
            # use tarballs
            additional_attributes = fetch_archive_details(spec['url'], spec['version'])
        else:
            # default: use git repositories
            additional_attributes = fetch_repo_details(spec['url'], spec['version'])
        add_attributes(repos["repositories"][repo], additional_attributes)
        print("{}: {}".format(repo, [*additional_attributes.values()]))

    with open(args.lock, "w", encoding='utf8') as lock_file:
        print(
            "#\n#   To update, call `bazel run @rules_ros//repos/config:repos_lock.update` with the right distro set in the WORKSPACE\n#",
            file = lock_file
        )
        yaml.dump(repos, lock_file, default_flow_style=False, allow_unicode=True)

def add_attributes(dictionary, additional_attributes):
    for k,v in additional_attributes.items():
        dictionary[k] = v

def fetch_archive_details(url, tag):
    cwd = os.getcwd()
    with tempfile.TemporaryDirectory() as tempdir:
        url = url.rsplit(".git", 1)[0]
        project = url.split('/')[-1]
        url += f"/archive/refs/tags/{tag}.tar.gz"
        result = subprocess.run(
            ["curl", "-L", "-f", "-o", "archive.tar.gz", url],
            stdout=subprocess.PIPE,
            encoding='utf8'
        )
        if result.returncode != 0:
            raise ValueError(f"Error loading {url}, {tag}: " + (result.stderr or ""))

        archive_bytes = Path('archive.tar.gz').read_bytes()
        hash = hashlib.sha256(archive_bytes).hexdigest()
        strip_prefix = extract_archive_root_folder("archive.tar.gz", url)

    return {
        "hash":hash,
        "url": url,
        "strip_prefix": strip_prefix,
        "type": "http_archive",
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


def fetch_repo_details(url, branch):
    cwd = os.getcwd()
    with tempfile.TemporaryDirectory() as tempdir:
        result = subprocess.run(
            ["git", "clone", url, "--no-checkout", tempdir, "--depth", "1",
             "--branch", branch, "--bare", "-q"],
            capture_output = True,
            encoding='utf8'
        )
        if result.returncode != 0:
            raise ValueError(result.stderr)
        os.chdir(tempdir)
        result = subprocess.run(
            ["git", "log", "--date=raw", "--format=format:%H/%cd"],
            stdout=subprocess.PIPE,
            encoding='utf8'
        )
        if result.returncode != 0:
            raise ValueError(result.stderr)
        commit_hash, time = result.stdout.split("/")
        os.chdir(cwd)
    return {
        "hash":commit_hash,
        "shallow_since": time,
    }


if __name__ == "__main__":
    main()