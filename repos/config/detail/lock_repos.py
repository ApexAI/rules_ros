#! /usr/bin/env python3

import argparse
import tempfile
import yaml
import subprocess
import os

def main():
    parser = argparse.ArgumentParser(description="Generate a lock file for a given repos file.")
    parser.add_argument('repos', type=str, help='Input YAML file')
    parser.add_argument('lock', type=str, help='Output YAML file with pinned repos')

    args = parser.parse_args()
    print(f"Calling {args.repos} {args.lock}")

    with open(args.repos, "r") as repos_file:
        repos = yaml.safe_load(repos_file)

    if repos.get("repositories") is None:
        raise ValueError("No repositories attribute found")

    for repo, spec in repos["repositories"].items():
        if spec["type"] != "git":
            raise ValueError(f"Repo type {spec['type']} not supported.")
        commit_hash, time = fetch_repo_details(spec['url'], spec['version'])
        repos["repositories"][repo]["hash"] = commit_hash
        repos["repositories"][repo]["shallow_since"] = time
        print("{}: {}, {}".format(repo, commit_hash, time))

    with open(args.lock, "w", encoding='utf8') as lock_file:
        print(
            "#\n#   To update, call `bazel run //repos/config:repos_lock.update` with the right distro set in the WORKSPACE\n#",
            file = lock_file
        )
        yaml.dump(repos, lock_file, default_flow_style=False, allow_unicode=True)


def fetch_repo_details(url, branch):
    cwd = os.getcwd()
    with tempfile.TemporaryDirectory() as tempdir:
        result = subprocess.run(
            ["git", "clone", url, "--no-checkout", tempdir, "--depth", "1",
             "--branch", branch, "--bare", "-q"],
            stdout=subprocess.PIPE,
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
    return commit_hash, time


if __name__ == "__main__":
    main()