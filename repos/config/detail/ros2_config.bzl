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

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "update_attrs")

_archive_attrs = {
    "repos_index": attr.label(
        doc = "YAML file containing the details of every ros2 repository.",
    ),
    "repos_index_overlays": attr.label_list(
        default = [],
        doc = """
            Additional YAML files used as overlays for `repo_index` e.g. to declare BUILD files
            for a repo.
        """,
    ),
    "setup_file": attr.label(
        doc = "Resulting .bzl file containing repo rules to load every ros2 repository.",
    ),
}

BUILD_FILE_CONTENT = """\
load("@rules_ros//repos/config/detail:generate_repos_lock.bzl", "generate_repos_lock")

generate_repos_lock(
    name = "repos_lock.update",
    repos_file = "ros.repos",  # Custom repos file
    setup_file = "setup.bzl",  # Custom setup file
    overlay_files = [
{overlays}
    ],
)

exports_files(glob(["**/*"]))
"""

def _ros2_config_impl(ctx):
    ctx.symlink(ctx.attr.repos_index, "ros.repos")
    ctx.symlink(ctx.attr.setup_file, "setup.bzl")
    i = 0
    overlay_files = []
    for file in ctx.attr.repos_index_overlays:
        filname = "overlay_{}.bzl".format(i)
        ctx.symlink(file, filname)
        i += 1
        overlay_files.append(filname)
    ctx.file("WORKSPACE", content = "workspace(name = {})".format(ctx.name), executable = False)
    ctx.file("BUILD.bazel", content = BUILD_FILE_CONTENT.format(overlays="\n".join(['        "{}",'.format(filename) for filename in overlay_files])), executable = False)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {})

ros2_config = repository_rule(
    implementation = _ros2_config_impl,
    attrs = _archive_attrs,
)
