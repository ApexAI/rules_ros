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
    "url": attr.string(
        doc = "URI of the archive.",
    ),
    "strip_prefix": attr.string(
        doc =
            "Path prefix to be stripped.",
    ),
    "sha256": attr.string(
        doc =
            "Hash of the commit to be checked out.",
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

def _http_archve_impl(ctx):
    """Implementation of the git_repository rule."""

    download_info = ctx.download_and_extract(
        ctx.attr.url,
        sha256 = ctx.attr.sha256,
        stripPrefix = ctx.attr.strip_prefix,
    )

    _workspace_and_buildfiles(ctx)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {"sha256": download_info.sha256})

http_archive = repository_rule(
    implementation = _http_archve_impl,
    attrs = _archive_attrs,
    doc =
        """Custom rule to use a compressed tarball for creating an external workspace.
        It allows to inject multiple BUILD files.
        """,
)
