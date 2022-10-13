#! /usr/bin/env python3
# Copyright 2022 Apex.AI, Inc.
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

import sys
import yaml


HEADER = """
load("@rules_ros//repos/config/detail:git_repository.bzl", _git_repository = "git_repository")
load("@rules_ros//repos/config/detail:new_local_repository.bzl", _new_local_repository = "new_local_repository")
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
    if spec['type'] == "git":
        return build_remote_load_command(repo, spec)
    if spec['type'] == "local":
        return build_local_load_command(repo, spec)
    else:
        raise ValueError(f"Unknown repo type {spec['type']}")


def build_local_load_command(repo, spec):
    build_files = "\n".join([f'            "{k}": "{v}",' for k,v in spec['bazel'].items()])
    return f"""
    print("Loading: @{repo.replace('/','.')}")
    _maybe(
        name = "{repo.replace('/','.')}",
        build_files = {{
{build_files}
        }},
        path = "{spec['path']}",
        repo_rule = _new_local_repository,
    )
"""

def build_remote_load_command(repo, spec):
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