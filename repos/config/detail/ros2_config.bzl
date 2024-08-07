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
    "repo_index": attr.label(
        doc = "YAML file containing the details of every ros2 repository.",
    ),
    "repo_index_overlays": attr.label_list(
        default = [],
        doc = """
            Additional YAML files used as overlays for `repo_index` e.g. to declare BUILD files
            for a repo.
        """,
    ),
    "_generate_ros2_config": attr.label(
        default = "generate_ros2_config.py",
    ),
    "verbose": attr.bool(
        default = False,
        doc = "Prints the calling sequence to stdout.",
    ),
}

def _ros2_config_impl(ctx):
    result = ctx.execute(
        [ctx.attr._generate_ros2_config, ctx.attr.repo_index] +
        ctx.attr.repo_index_overlays,
    )
    if result.return_code != 0:
        fail(result.stderr)

    ctx.file("setup.bzl", content = result.stdout)
    ctx.file("repos_lock_file.bzl", content = "REPOS_LOCK_FILE = '{}'".format(ctx.attr.repo_index))
    ctx.file("WORKSPACE", content = "workspace(name = {}".format(ctx.name), executable = False)
    ctx.file("BUILD", executable = False)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {})

ros2_config = repository_rule(
    implementation = _ros2_config_impl,
    attrs = _archive_attrs,
)
