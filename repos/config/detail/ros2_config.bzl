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

def _ros2_config_impl(ctx):
    ctx.file("repos_index_file.bzl", content = "REPOS_INDEX_FILE = '{}'".format(ctx.attr.repos_index))
    ctx.file("repos_overlay_files.bzl", content = "REPOS_OVERLAY_FILES = {}".format(["{}".format(l) for l in ctx.attr.repos_index_overlays]))
    ctx.file("repos_setup_file.bzl", content = "REPOS_SETUP_FILE = '{}'".format(ctx.attr.setup_file))
    ctx.symlink(ctx.attr.setup_file, "setup.bzl")
    ctx.file("WORKSPACE", content = "workspace(name = {})".format(ctx.name), executable = False)
    ctx.file("BUILD.bazel", content = "exports_files(glob(['**/*']))", executable = False)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {})

ros2_config = repository_rule(
    implementation = _ros2_config_impl,
    attrs = _archive_attrs,
)
