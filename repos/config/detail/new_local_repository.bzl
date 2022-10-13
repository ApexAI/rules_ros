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
    "path": attr.string(
        doc = "Path to the repository.",
    ),
    "build_files": attr.label_keyed_string_dict(
        doc =
            "Same as in native rule.",
    ),
}

def _execute_or_fail(ctx, args, **kwargs):
    result = ctx.execute(args, **kwargs)
    if result.return_code != 0:
        fail(result.stderr)
    return result

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

def _files_in_directory(ctx, directory_path):
    exec_result = ctx.execute(["find", directory_path, "-maxdepth", "1", "-mindepth", "1"])
    if exec_result.return_code != 0:
        fail(exec_result.stderr)

    return exec_result.stdout.splitlines()

def _new_local_repository_impl(ctx):
    """Implementation of the git_repository rule."""

    for f in _files_in_directory(ctx, ctx.attr.path):
        _execute_or_fail(ctx, ["cp", "-r", f, f.rpartition("/")[2]])

    _workspace_and_buildfiles(ctx)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {})

new_local_repository = repository_rule(
    implementation = _new_local_repository_impl,
    attrs = _archive_attrs,
    doc =
        """Custom rule to clone a git repo as external dependency.
        It allows to inject multiple BUILD files.
        """,
)

