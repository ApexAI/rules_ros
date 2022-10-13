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

load("@rules_pkg//:providers.bzl", "PackageFilegroupInfo", "PackageFilesInfo")
load("@rules_python//python:packaging.bzl", "PyWheelInfo")
load(
    ":utils.bzl",
    _add_filegroup = "add_filegroup",
    _add_files_to_filegroup_info = "add_files_to_filegroup_info",
    _build_attributes = "build_attributes",
    _create_ros_pkg_info = "create_ros_pkg_info",
    _create_ros_pkg_set_info = "create_ros_pkg_set_info",
    _unique_pkg_names_or_fail = "unique_pkg_names_or_fail",
)
load("@rules_ros//pkg:providers.bzl", _RosPkgInfo = "RosPkgInfo")

RESOURCE_PATH_PREFIX = "share/bazel-bin/"
LIBRARY_PATH = "lib/{pkg_name}/"
BIN_PATH = "bin/"
WHEELS_PATH = "share/wheels/"

def _build_pkg_name(ctx):
    name_parts = [ctx.workspace_name]
    name_parts.extend(ctx.label.package.split("/"))
    if ctx.label.name != name_parts[-1]:
        name_parts.append(ctx.label.name)

    return "_".join(name_parts)

def _build_package_xml(ctx, pkg_name):
    output = ctx.actions.declare_file("/".join([ctx.label.name, "package.xml"]))
    ctx.actions.run(
        executable = ctx.executable._package_xml_generator,
        arguments = [
            output.path,
            "--pkg_name",
            pkg_name,
            "--maintainer_email",
            ctx.attr.maintainer_email,
            "--maintainer_name",
            ctx.attr.maintainer_name,
            "--version",
            ctx.attr.version,
            "--license",
            ctx.attr.license,
            "--description",
            ctx.attr.description,
        ],
        outputs = [output],
    )
    return "share/{}/package.xml".format(pkg_name), output

def _build_ament_index(ctx, pkg_name):
    output = ctx.actions.declare_file("{}/ament_index/resource_index/packages/{}".format(ctx.label.name, pkg_name))
    ctx.actions.write(output, "")
    return "share/ament_index/resource_index/packages/{}".format(pkg_name), output

def _build_executable_wrapper(ctx, path, file):
    resource_path_list = [".."] * (len(path.split("/")) - 1)
    resource_path_list.append(RESOURCE_PATH_PREFIX)
    output = ctx.actions.declare_file("resource/{}".format(file.basename))
    ctx.actions.run(
        executable = ctx.executable._executable_wrapper_generator,
        arguments = [
            output.path,
            file.short_path,
            "/".join(resource_path_list),
        ],
        outputs = [output],
    )
    return output

def _create_package_files_info(files, *, executable = False, prefix, use_basename = False):
    attributes = _build_attributes(executable = executable)
    return PackageFilesInfo(
        dest_src_map = {
            "{}{}".format(
                prefix,
                f.basename if use_basename else f.short_path,
            ): f
            for f in files
        },
        attributes = attributes,
    )

def _add_package_files(ctx, pkg_name, pkg_files_info, outputs):
    for factory_method in [_build_package_xml, _build_ament_index]:
        path, file = factory_method(ctx, pkg_name)
        _add_files_to_filegroup_info(
            pkg_files_info,
            PackageFilesInfo(
                attributes = _build_attributes(),
                dest_src_map = {path: file},
            ),
            ctx.label,
        )
        outputs.append(file)

def _add_executable_runfiles(ctx, pkg_files_info, outputs):
    targets = ctx.attr.lib_executables + ctx.attr.bin_executables
    for target in targets:
        _add_files_to_filegroup_info(
            pkg_files_info,
            _create_package_files_info(
                target[DefaultInfo].default_runfiles.files.to_list(),
                prefix = RESOURCE_PATH_PREFIX,
                executable = True,
            ),
            target.label,
        )
        outputs.append(target[DefaultInfo].default_runfiles.files)

def _add_executable_wrappers(ctx, pkg_name, pkg_files_info, outputs):
    for executables, path in [
        (ctx.files.lib_executables, LIBRARY_PATH.format(pkg_name = pkg_name)),
        (ctx.files.bin_executables, BIN_PATH),
    ]:
        executable_wrappers = [
            _build_executable_wrapper(ctx, path, executable)
            for executable in executables
        ]
        outputs.extend(executable_wrappers)
        _add_files_to_filegroup_info(
            pkg_files_info,
            _create_package_files_info(
                executable_wrappers,
                prefix = path,
                executable = True,
                use_basename = True,
            ),
            ctx.label,
        )

def _add_py_wheels(ctx, pkg_files_info, transitive_outputs):
    for target in ctx.attr.py_packages:
        _add_files_to_filegroup_info(
            pkg_files_info,
            _create_package_files_info(
                [target[PyWheelInfo].wheel],
                prefix = WHEELS_PATH,
                use_basename = True,
            ),
            ctx.label,
        )
        transitive_outputs.append(target[DefaultInfo].default_runfiles.files)

def _ros_pkg_impl(ctx):
    outputs = []
    transitive_outputs = []
    pkg_files_info = PackageFilegroupInfo(
        pkg_files = [],
        pkg_dirs = [],
        pkg_symlinks = [],
    )

    if ctx.attr._unnamed_pkg:
        ros_pkg_info = _create_ros_pkg_set_info(ctx.attr.deps)
    else:
        pkg_name = ctx.attr.pkg_name if ctx.attr.pkg_name != "" else _build_pkg_name(ctx)
        ros_pkg_info = _create_ros_pkg_info(ctx, pkg_name)

        _add_package_files(ctx, pkg_name, pkg_files_info, outputs)
        _add_executable_runfiles(ctx, pkg_files_info, transitive_outputs)
        _add_executable_wrappers(ctx, pkg_name, pkg_files_info, outputs)
        _add_py_wheels(ctx, pkg_files_info, transitive_outputs)

    for ros_pkg_target in ctx.attr.deps:
        _add_filegroup(ros_pkg_target, pkg_files_info, transitive_outputs)

    _unique_pkg_names_or_fail(ros_pkg_info)

    return [
        ros_pkg_info,
        pkg_files_info,
        DefaultInfo(files = depset(direct = outputs, transitive = transitive_outputs)),
    ]

ros_pkg_set = rule(
    implementation = _ros_pkg_impl,
    attrs = {
        "deps": attr.label_list(
            mandatory = False,
            providers = [_RosPkgInfo],
        ),
        "_unnamed_pkg": attr.bool(
            default = True,
        ),
    },
)

ros_pkg = rule(
    implementation = _ros_pkg_impl,
    attrs = {
        "pkg_name": attr.string(
            mandatory = False,
        ),
        "description": attr.string(
            mandatory = True,
        ),
        "version": attr.string(
            mandatory = True,
        ),
        "maintainer_name": attr.string(
            mandatory = True,
        ),
        "maintainer_email": attr.string(
            mandatory = False,
        ),
        "license": attr.string(
            mandatory = True,
        ),
        "lib_executables": attr.label_list(
            mandatory = False,
        ),
        "bin_executables": attr.label_list(
            mandatory = False,
        ),
        "py_packages": attr.label_list(
            mandatory = False,
            providers = [PyWheelInfo],
        ),
        "deps": attr.label_list(
            mandatory = False,
            providers = [_RosPkgInfo],
        ),
        "_package_xml_generator": attr.label(
            default = ":package_xml.generate",
            executable = True,
            cfg = "exec",
        ),
        "_executable_wrapper_generator": attr.label(
            default = ":executable_wrapper.generate",
            executable = True,
            cfg = "exec",
        ),
        "_unnamed_pkg": attr.bool(
            default = False,
        ),
    },
)
