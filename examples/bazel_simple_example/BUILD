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
load("@rules_ros//pkg:defs.bzl", "ros_pkg")

cc_binary(
    name = "publisher",
    srcs = ["publisher.cpp"],
    deps = [
        "@ros2.common_interfaces//std_msgs",
        "@ros2.rclcpp//rclcpp",
    ],
)

cc_binary(
    name = "subscriber",
    srcs = ["subscriber.cpp"],
    deps = [
        "@ros2.common_interfaces//std_msgs",
        "@ros2.rclcpp//rclcpp",
    ],
)

ros_pkg(
    name = "bazel_simple_example_pkg",
    description = "Simple pub/sub example",
    lib_executables = [
        "publisher",
        "subscriber",
    ],
    license = "Apex.AI License",
    maintainer_email = "kilian.funk@apex.ai",
    maintainer_name = "Kilian Funk",
    pkg_name = "bazel_simple_example",
    version = "1.0.0",
    visibility = ["//visibility:public"],
)
