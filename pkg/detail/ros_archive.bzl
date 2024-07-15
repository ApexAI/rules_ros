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

load("@rules_pkg//pkg:providers.bzl", "PackageFilegroupInfo", "PackageFilesInfo")
load(
    ":utils.bzl",
    _add_filegroup = "add_filegroup",
    _add_files_to_filegroup_info = "add_files_to_filegroup_info",
    _build_attributes = "build_attributes",
    _create_ros_pkg_set_info = "create_ros_pkg_set_info",
    _unique_pkg_names_or_fail = "unique_pkg_names_or_fail",
)
load("@rules_ros//pkg:providers.bzl", _RosPkgInfo = "RosPkgInfo")

def _build_setup_bash(ctx):
    output = ctx.actions.declare_file("/".join([ctx.label.name, "setup.bash"]))
    ctx.actions.run(
        executable = ctx.executable._setup_bash_generator,
        arguments = [output.path],
        outputs = [output],
    )
    return "setup.bash", output

def is_unique(list_of_items):
    return len(list_of_items) == len({i: None for i in list_of_items})

def _add_setup_bash(ctx, pkg_files_info, outputs):
    path, file = _build_setup_bash(ctx)
    _add_files_to_filegroup_info(
        pkg_files_info,
        PackageFilesInfo(
            attributes = _build_attributes(),
            dest_src_map = {path: file},
        ),
        ctx.label,
    )
    outputs.append(file)

def ros_archive_impl(ctx):
    outputs = []
    transitive_outputs = []

    pkg_files_info = PackageFilegroupInfo(
        pkg_files = [],
        pkg_dirs = [],
        pkg_symlinks = [],
    )

    _unique_pkg_names_or_fail(_create_ros_pkg_set_info(ctx.attr.ros_pkgs))

    _add_setup_bash(ctx, pkg_files_info, outputs)
    for ros_pkg_target in ctx.attr.ros_pkgs:
        _add_filegroup(ros_pkg_target, pkg_files_info, transitive_outputs)

    return [
        pkg_files_info,
        DefaultInfo(files = depset(direct = outputs, transitive = transitive_outputs)),
    ]

ros_archive_pkg_files = rule(
    attrs = {
        "ros_pkgs": attr.label_list(
            mandatory = True,
            providers = [PackageFilegroupInfo, _RosPkgInfo],
        ),
        "_setup_bash_generator": attr.label(
            default = ":setup_bash.generate",
            executable = True,
            cfg = "exec",
        ),
    },
    implementation = ros_archive_impl,
)

def _ros_archive_install_command_impl(ctx):
    output = ctx.actions.declare_file(ctx.attr.name)
    ctx.actions.expand_template(
        output = output,
        is_executable = True,
        template = ctx.file._install_bash_template,
        substitutions = {
            "{{file}}": ctx.file.pkg_archive.short_path,
            "{{name}}": ctx.attr.group_name,
        },
    )
    return [
        DefaultInfo(
            files = depset([output]),
            executable = output,
            runfiles = ctx.runfiles([output, ctx.file.pkg_archive]),
        ),
    ]

ros_archive_install_command = rule(
    implementation = _ros_archive_install_command_impl,
    executable = True,
    attrs = {
        "_install_bash_template": attr.label(
            default = "templates/install.template",
            allow_single_file = True,
        ),
        "pkg_archive": attr.label(
            allow_single_file = True,
        ),
        "group_name": attr.string(
            mandatory = True,
        ),
    },
)
