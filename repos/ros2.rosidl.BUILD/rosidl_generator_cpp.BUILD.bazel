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
# load("//apex_os/core/rosidl/rules_rosidl:defs.bzl", "cc_msgs_library")

py_library(
    name = "rosidl_generator_cpp_python",
    srcs = [
        "rosidl_generator_cpp/__init__.py",
    ],
    imports = ["."],
    deps = [
        "@ros2.rosidl//rosidl_cmake:rosidl_cmake_python",
        "@ros2.rosidl//rosidl_parser:rosidl_parser_python",
    ],
)

copy_file(
    name = "rosidl_generator_cpp_with_py_extension",
    src = "bin/rosidl_generator_cpp",
    out = "generator.py",
    allow_symlink = True,
)

py_binary(
    name = "generator",
    srcs = [
        "generator.py",
    ],
    legacy_create_init = 0,  # required for py_binaries used on execution platform
    visibility = ["//visibility:public"],
    deps = [
        ":rosidl_generator_cpp_python",
    ],
)

filegroup(
    name = "resource",
    srcs = glob(["resource/*.em"]),
    visibility = ["//visibility:public"],
)

# Test run
# cc_msgs_library(
#     name = "messages",
#     srcs = glob(
#         [
#             "msg/*.idl",
#             "srv/*.srv",
#         ],
#         exclude = [
#             "msg/Malformatted.idl",
#             "msg/UnknownTypes.idl",
#             "msg/WStrings.idl",  # Exclude as cyclonedds does not support wstrings
#             "msg/WChar.idl",  # Exclude as cyclonedds does not support wchar
#         ],
#     ),
#     visibility = ["//visibility:public"],
# )
