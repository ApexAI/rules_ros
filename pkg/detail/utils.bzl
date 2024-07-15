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

load("@rules_pkg//pkg:providers.bzl", _PackageFilegroupInfo = "PackageFilegroupInfo")
load("@rules_ros//pkg:providers.bzl", _RosPkgInfo = "RosPkgInfo")

def add_files_to_filegroup_info(filegroup_info, pkg_files_info, label):
    filegroup_info.pkg_files.append((pkg_files_info, label))

def build_attributes(*, executable = False):
    return {"mode": "0755"} if executable else {"mode": "0644"}

def add_filegroup(ros_pkg_target, pkg_files_info, transitive_outputs):
    pfi = ros_pkg_target[_PackageFilegroupInfo]
    pkg_files_info.pkg_files.extend(pfi.pkg_files)
    pkg_files_info.pkg_dirs.extend(pfi.pkg_dirs)
    pkg_files_info.pkg_symlinks.extend(pfi.pkg_symlinks)
    transitive_outputs.append(ros_pkg_target[DefaultInfo].files)

def create_ros_pkg_info(ctx, pkg_name):
    return _RosPkgInfo(
        name = pkg_name,
        description = ctx.attr.description,
        version = ctx.attr.version,
        maintainer_name = ctx.attr.maintainer_name,
        maintainer_email = ctx.attr.maintainer_email,
        license = ctx.attr.license,
        lib_executables = ctx.attr.lib_executables,
        bin_executables = ctx.attr.bin_executables,
        py_packages = ctx.attr.py_packages,
        deps = _build_ros_pkg_info_deps(ctx.attr.deps),
    )

def create_ros_pkg_set_info(ros_pkgs):
    return _RosPkgInfo(
        name = None,
        deps = _build_ros_pkg_info_deps(ros_pkgs),
    )

def _build_ros_pkg_info_deps(deps):
    direct_deps = [pkg for pkg in deps]
    return depset(
        direct = [pkg for pkg in direct_deps if pkg[_RosPkgInfo].name],
        transitive = [pkg[_RosPkgInfo].deps for pkg in direct_deps],
    )

def _are_unique(list_of_items):
    return len(list_of_items) == len({i: None for i in list_of_items})

def unique_pkg_names_or_fail(ros_pkg_info):
    pkg_names = [ros_pkg[_RosPkgInfo].name for ros_pkg in ros_pkg_info.deps.to_list()]
    if ros_pkg_info.name:
        pkg_names.append(ros_pkg_info.name)
    if not _are_unique(pkg_names):
        fail("ROS package names must be unique in a ros_archive.")
