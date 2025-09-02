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

load("@bazel_skylib//rules:copy_file.bzl", "copy_file")
load("@rules_python//python:py_library.bzl", "py_library")

py_library(
    name = "rosidl_typesupport_c_python",
    srcs = [
        "rosidl_typesupport_c/__init__.py",
    ],
    imports = ["."],
    deps = [
        "@ros2.rosidl//rosidl_cmake:rosidl_cmake_python",
    ],
)

copy_file(
    name = "rosidl_typesupport_c_with_py_extension",
    src = "bin/rosidl_typesupport_c",
    out = "generator.py",
    allow_symlink = True,
)

py_binary(
    name = "generator",
    srcs = [
        ":generator.py",
    ],
    legacy_create_init = 0,  # required for py_binaries used on execution platform
    visibility = ["//visibility:public"],
    deps = [
        ":rosidl_typesupport_c_python",
        "@ros2.rosidl//rosidl_cmake:rosidl_cmake_python",
        "@ros2.rosidl//rosidl_parser:rosidl_parser_python",
    ],
)

cc_library(
    name = "rosidl_typesupport_c",
    srcs = glob([
        "src/*.c",
        "src/*.cpp",
        "src/*.hpp",
    ]),
    hdrs = glob([
        "include/rosidl_typesupport_c/*.h",
    ]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        #"//apex_os/core/dds_typesupport",
        "@ros2.rosidl//rosidl_runtime_c",
        "@ros2.rcpputils//:rcpputils",
    ],
)

filegroup(
    name = "config_files",
    srcs = glob(["resource/*.in"], allow_empty = True),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "resource",
    srcs = glob(["resource/*.em"]),
    visibility = ["//visibility:public"],
)

exports_files([
    "resource/rosidl_typesupport_c__visibility_control.h.in",
])
