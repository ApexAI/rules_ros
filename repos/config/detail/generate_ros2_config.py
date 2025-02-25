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

import yaml
import hashlib
import os

def get_sha256sum(file):
    sha256_hash = hashlib.sha256()
    with open(file, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def print_setup(repos, output_file, repos_file, overlay_files, workspace_name, use_tar = False):
    BZL_CMD = f"bazel run @{workspace_name}//:repos_lock.update"
    if use_tar:
        BZL_CMD += " -- --tar"
    HEADER = f"""#
# DO NOT EDIT THIS FILE MANUALLY!
#
# To update, call `{BZL_CMD}` with the right distro set in the WORKSPACE
#
# SHA256 of @{workspace_name}//:ros.repos: {get_sha256sum(repos_file)}
# SHA256 of overlays:
#{', '.join([f' @{workspace_name}//:{os.path.basename(overlay)}: {get_sha256sum(overlay)}' for overlay in overlay_files]) if overlay_files else ""}

load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
load("@rules_ros//repos/config/detail:git_repository.bzl", "git_repository")
load("@rules_ros//repos/config/detail:http_archive.bzl", "http_archive")
load("@rules_ros//repos/config/detail:new_local_repository.bzl", "new_local_repository")

def setup():
    pass
"""

    print(HEADER, file=output_file)
    printed_first_load = False
    for repo, spec in repos.items():
        if spec.get("bazel") is not None:
            if printed_first_load:
                output_file.write("\n")
            output_file.write(build_load_command(repo, spec))
            printed_first_load = True


def build_load_command(repo, spec):
    builder = {
        "git": build_git_load_command,
        "http_archive": build_http_archive_load_command,
        "local": build_local_load_command,
    }
    if spec.get('type') not in builder.keys():
        return f"""\
    print("WARNING: Unknown repo type {spec.get('type')} for repo @{repo.replace('/', '.')}")
"""
    return builder[spec.get('type')](repo, spec)


def build_build_files_attr(build_files):
    if not build_files:
        return ""
    content = '\n'.join(f'            "{k}": "{v}",' for k,v in build_files.items())
    return f"""build_files = {{
{content}
        }},"""


def build_http_archive_load_command(repo, spec):
    patches = {''.join(f'\n            "{i}",' for i in spec.get('patches', []))}
    patches_args = {''.join(f'\n            "{{i}}",' for i in spec.get('patch_args', []))}
    return f"""
    _maybe(
        name = "{repo.replace('/','.')}",
        {build_build_files_attr(spec['bazel'])}
        url = "{spec['url']}",
        sha256 = "{spec['hash']}",
        strip_prefix = "{spec['strip_prefix']}",
        repo_rule = http_archive,
        patches = [
            {patches}
        ],
        patch_args = [
            {patches_args}
        ],
    )
"""

def build_local_load_command(repo, spec):
    return f"""\
    _maybe(
        name = "{repo.replace('/','.')}",
        {build_build_files_attr(spec['bazel'])}
        path = "{spec['path']}",
        sha256 = "{spec['hash']}",
        repo_rule = new_local_repository,
    )
"""

def build_git_load_command(repo, spec):
    return f"""\
    _maybe(
        name = "{repo.replace('/','.')}",
        branch = "{spec['version']}",
        {build_build_files_attr(spec['bazel'])}
        commit = "{spec['hash']}",
        remote = "{spec['url']}",
        repo_rule = git_repository,
        shallow_since = "{spec['shallow_since']}",
    )
"""


def merge_dict(origin, to_add):
    for key, value in to_add.items():
        if key in origin and isinstance(origin[key], dict):
            merge_dict(origin[key],value)
        else:
            origin[key]=value


def print_setup_file(repos, overlay_files, output_file, repos_file, workspace_name, use_tar = False):
    for input_path in overlay_files:
        with (open(input_path,"r")) as repo_file:
            merge_dict(repos, yaml.safe_load(repo_file)["repositories"])

    print_setup(repos, output_file, repos_file, overlay_files, workspace_name, use_tar)
