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

load("@rules_ros//utils:template_expansion.bzl", "cc_library_from_template")
load("@python_deps//:requirements.bzl", "requirement")

cc_library(
    name = "rclcpp",
    srcs = glob(["src/**/*.cpp", "src/**/*.hpp"]),
    hdrs = glob(["include/**/*.hpp"]),
    strip_include_prefix = "include",
    deps = [
        "@ament.ament_index//ament_index_cpp",
        "@ros2.rcl//rcl",
        "@ros2.rmw//rmw",
        "@ros2.rcpputils//:rcpputils",
        "@ros2.rcl_interfaces//rosgraph_msgs",
        "@ros-tooling.libstatistics_collector//:libstatistics_collector",
        ":logging",
        ":get_interfaces",
        ":interface_traits",
    ],
    visibility = ["//visibility:public"],
)

cc_library_from_template(
    name = "logging",
    generator_script = "@ros2.rcutils//:build_logging_macros",
    template = "resource/logging.hpp.em",
    package_name = "rclcpp"
)

NODE_INTERFACES = [
    "node_base",
    "node_clock",
    "node_graph",
    "node_logging",
    "node_parameters",
    "node_services",
    "node_time_source",
    "node_timers",
    "node_topics",
    "node_waitables",
]

cc_library_from_template(
    name = "get_interfaces",
    generator_script = ":build_interfaces",
    template = "resource/get_interface.hpp.em",
    output_pattern = "node_interfaces/get_{interface_name}.hpp",
    package_name = "rclcpp",
    variables = {"interface_name": [interface + "_interface" for interface in NODE_INTERFACES]},
)

cc_library_from_template(
    name = "interface_traits",
    generator_script = ":build_interfaces",
    template = "resource/interface_traits.hpp.em",
    output_pattern = "node_interfaces/{interface_name}_traits.hpp",
    package_name = "rclcpp",
    variables = {"interface_name": [interface + "_interface" for interface in NODE_INTERFACES]},
)


py_binary(
    name = "build_interfaces",
    srcs = ["build_interfaces.py"],
    deps = [
        requirement("empy"),
    ],
)
