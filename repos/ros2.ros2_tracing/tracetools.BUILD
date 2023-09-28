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
    name = "tracetools",
    srcs = [
        "src/tracetools.c",
        "src/utils.cpp",
    ],
    hdrs = [
        "include/tracetools/tracetools.h",
        "include/tracetools/utils.hpp",
        "include/tracetools/visibility_control.hpp",
        ":config",
    ],
    strip_include_prefix = "include",
    deps = ["@ros2.rcutils//:rcutils"],
    visibility = ["//visibility:public"],
)

# ToDo: config not yet fully implemented
expand_template(
    name = "config",
    out = "include/tracetools/config.h",
    substitutions = {
        "#cmakedefine TRACETOOLS_DISABLED": "#define TRACETOOLS_DISABLED 1",
        "#cmakedefine TRACETOOLS_LTTNG_ENABLED": ""
    },
    template = "include/tracetools/config.h.in",
)


