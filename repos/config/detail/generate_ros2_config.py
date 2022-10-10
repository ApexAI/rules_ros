#! /usr/bin/env python3
import sys
import yaml


HEADER = """
load("@rules_ros//repos/config/detail:git_repository.bzl", _git_repository = "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")

def setup():
    pass
"""


def print_setup(repos):
    print(HEADER)
    for repo, spec in repos.items():
        if spec.get("bazel") is not None:
            print(build_load_command(repo, spec))


def build_load_command(repo, spec):
    build_files = "\n".join([f'            "{k}": "{v}",' for k,v in spec['bazel'].items()])
    return f"""
    print("Loading: @{repo.replace('/','.')}")
    _maybe(
        name = "{repo.replace('/','.')}",
        branch = "{spec['version']}",
        build_files = {{
{build_files}
        }},
        commit = "{spec['hash']}",
        remote = "{spec['url']}",
        repo_rule = _git_repository,
        shallow_since = "{spec['shallow_since']}",
    )
"""


def merge_dict(origin, to_add):
    for key, value in to_add.items():
        if key in origin and isinstance(origin[key], dict):
            merge_dict(origin[key],value)
        else:
            origin[key]=value


def main():
    if len(sys.argv) < 2:
        raise ValueError("At least one YAML file required as input.")

    repos = {}
    for input_path in sys.argv[1:]:
        with (open(input_path,"r")) as repo_file:
            merge_dict(repos, yaml.safe_load(repo_file)["repositories"])

    print_setup(repos)


if __name__ == "__main__":
    main()