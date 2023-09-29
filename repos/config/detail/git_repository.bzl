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

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "update_attrs")

_archive_attrs = {
    "remote": attr.string(
        doc = "URI of the repository.",
    ),
    "branch": attr.string(
        doc =
            "Branch to be checked out.",
    ),
    "commit": attr.string(
        doc =
            "Hash of the commit to be checked out.",
    ),
    "shallow_since": attr.string(
        doc =
            "Time of required commit.",
    ),
    "build_files": attr.label_keyed_string_dict(
        doc = """
            Dict with a file as key and the path where to place the file in the repository as value.
            This allows to place multiple (BUILD) files in a repo.
        """,
    ),
}

def _execute_or_fail(ctx, args, **kwargs):
    result = ctx.execute(args, **kwargs)
    if result.return_code != 0:
        fail(result.stderr)
    return result

def _git_clone(ctx):
    _execute_or_fail(ctx, [
        "git",
        "clone",
        ctx.attr.remote,
        ".",
        "--branch",
        ctx.attr.branch,
        "--shallow-since=" + ctx.attr.shallow_since,
    ])
    _execute_or_fail(ctx, [
        "git",
        "checkout",
        ctx.attr.commit,
    ])

def _file_exists(ctx, file_name):
    exec_result = ctx.execute(["ls", file_name])
    if exec_result.return_code != 0:
        return False
    return True

def _workspace_and_buildfiles(ctx):
    if not _file_exists(ctx, "WORKSPACE") and not _file_exists(ctx, "WORKSPACE.bazel"):
        ctx.file("WORKSPACE", content = 'workspace(name = "{}")'.format(ctx.name))

    if not _file_exists(ctx, "WORKSPACE"):
        ctx.symlink("WORKSPACE", "WORKSPACE.bazel")

    for label, destinations in ctx.attr.build_files.items():
        if type(destinations) != type([]):
            destinations = [destinations]
            for destination in destinations:
                ctx.symlink(label, destination)

def _git_repository_impl(ctx):
    """Implementation of the git_repository rule."""

    _git_clone(ctx)

    _workspace_and_buildfiles(ctx)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {})

git_repository = repository_rule(
    implementation = _git_repository_impl,
    attrs = _archive_attrs,
    doc =
        """Custom rule to clone a git repo as external dependency.
        It allows to inject multiple BUILD files.
        """,
)
