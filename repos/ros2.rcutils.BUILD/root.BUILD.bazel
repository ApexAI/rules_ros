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

load("@rules_ros//utils:template_expansion.bzl", "cc_library_from_template")
load("@python_deps//:requirements.bzl", "requirement")

cc_library(
    name = "rcutils",
    srcs = glob([
        "src/*.c",
        "src/*.h",
        ],
        exclude = ["src/time_*.c"],
    ) +select({
        "@bazel_tools//src/conditions:windows": ["src/time_win32.c"],
        "//conditions:default": ["src/time_unix.c"],
    }),
    hdrs = glob(["include/**/*.h"]),
    # linkopts = ["-ldl"],
    strip_include_prefix = "include",
    local_defines = ['ROS_PACKAGE_NAME=\\\"rcutils\\\"', "_GNU_SOURCE"],
    deps = [
        #":private_rcutils_includes",
        ":logging_macros",
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "private_rcutils_includes",
    hdrs = glob(["src/*.h"]),
    strip_include_prefix = "src",
)


py_library(
    name = "logging",
    srcs = [
        "rcutils/__init__.py",
        "rcutils/logging.py",
    ],
    imports = ["rcutils"],
    visibility = ["//visibility:public"],
    deps = [
        requirement("empy"),
    ],
)

py_binary(
    name = "build_logging_macros",
    srcs = ["build_logging_macros.py"],
    visibility = ["//visibility:public"],
    deps = [
        ":logging",
    ],
)

cc_library_from_template(
    name = "logging_macros",
    generator_script = ":build_logging_macros",
    template = "resource/logging_macros.h.em",
    package_name = "rcutils",
)
