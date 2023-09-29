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

load("@bazel_skylib//rules:expand_template.bzl","expand_template")

cc_library(
    name = "libstatistics_collector",
    srcs = glob([
        "src/**/*.c",
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
        "include/**/*.hpp",
    ]),
    strip_include_prefix = "include",
    deps = [
        "@ros2.rcl_interfaces//builtin_interfaces",
        "@ros2.rcpputils//:rcpputils",
        "@ros2.rcl_interfaces//statistics_msgs",
    ],
    visibility = ["//visibility:public"],
)
