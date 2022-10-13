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
    name = "rosidl_generator_c_python",
    srcs = [
        "rosidl_generator_c/__init__.py",
    ],
    imports = ["."],
    visibility = ["//visibility:public"],
    deps = [
        "@ros2.rosidl//rosidl_cmake:rosidl_cmake_python",
        "@ros2.rosidl//rosidl_parser:rosidl_parser_python",
    ],
)

copy_file(
    name = "rosidl_generator_c_with_py_extension",
    src = "bin/rosidl_generator_c",
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
        ":rosidl_generator_c_python",
    ],
)

filegroup(
    name = "resource",
    srcs = glob(["resource/*.em"]),
    visibility = ["//visibility:public"],
)

exports_files([
    "resource/rosidl_generator_c__visibility_control.h.in",
])

# Test run (In cmake only enabled if APEX_CERT is not set)
# cc_msgs_library(
#     name = "messages",
#     srcs = glob(
#         [
#             "msg/*.idl",
#             "srv/*.srv",
#         ],
#         exclude = [
#             "msg/WStrings.idl",  # Exclude as cyclonedds does not support wstrings
#         ],
#     ),
#     visibility = ["//visibility:private"],
# )
#
# cc_test(
#     name = "test_compilation_c",
#     srcs = [
#         "test/separate_compilation.c",
#         "test/separate_compilation.h",
#         "test/test_compilation.c",
#     ],
#     linkopts = ["-ldl"],
#     visibility = ["//visibility:private"],
#     deps = [":messages"],
# )
#
# # Does not compile as it relies on wstring
# #cc_test(
# #    name = "test_interfaces_c",
# #    srcs = ["test/test_interfaces.c"],
# #    deps = [ ":messages" ],
# #    visibility = ["//visibility:private"],
# #)
#
# cc_test(
#     name = "test_invalid_initialization_c",
#     srcs = ["test/test_invalid_initialization.c"],
#     linkopts = ["-ldl"],
#     visibility = ["//visibility:private"],
#     deps = [":messages"],
# )

cc_test(
    name = "test_strict_aliasing_c",
    srcs = ["test/test_strict_aliasing.c"],
    linkopts = ["-ldl"],
    visibility = ["//visibility:private"],
    deps = [":messages"],
)
