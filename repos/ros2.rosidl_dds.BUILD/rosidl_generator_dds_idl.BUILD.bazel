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

load("@bazel_skylib//rules:copy_file.bzl", "copy_file")

py_library(
    name = "rosidl_generator_dds_idl_python",
    srcs = [
        "rosidl_generator_dds_idl/__init__.py",
    ],
    imports = ["."],
)

copy_file(
    name = "rosidl_generator_dds_idl_with_py_extension",
    src = "bin/rosidl_generator_dds_idl",
    out = "generator.py",
    allow_symlink = True,
)

filegroup(
    name = "resource",
    srcs = glob(["resource/*.em"]),
    visibility = ["//visibility:public"],
)

py_binary(
    name = "generator",
    srcs = [
        "rosidl_generator_dds_idl_with_py_extension",
    ],
    data = [
        ":resource",
    ],
    legacy_create_init = 0,  # required for py_binaries used on execution platform
    visibility = ["//visibility:public"],
    deps = [
        ":rosidl_generator_dds_idl_python",
        # "//apex_os/core/apex_dds/apex_middleware/apex_middleware_typefiles_generator",
        "@ros2.rosidl//rosidl_cmake:rosidl_cmake_python",
        # "//apex_os/core/rosidl/rosidl_parser:rosidl_parser_python",
    ],
)
