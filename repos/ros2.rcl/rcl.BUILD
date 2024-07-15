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

cc_library(
    name = "rcl",
    srcs = glob([
        "src/**/*.c",
        "src/**/*.h",
    ]),
    hdrs = glob(["include/**/*.h"]),
    strip_include_prefix = "include",
    deps = [
        "@ros2.rcutils//:rcutils",
        "@ros2.rmw//rmw",
        "@ros2.rosidl//rosidl_runtime_c",
        "@ros2.ros2_tracing//tracetools",
        "//rcl_yaml_param_parser",
        "@ros2.rcl_logging//rcl_logging_interface",
        "@ros2.rcl_interfaces//rcl_interfaces",
    ],
    local_defines = ["ROS_PACKAGE_NAME=\\\"rcl\\\""],
    visibility = ["//visibility:public"],
)

