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

workspace(name = "rules_ros")

load("//repos/config:defs.bzl", "configure_ros2")

configure_ros2(distro = "humble")

load("@ros2_config//:setup.bzl", "setup")

setup()

load("@rules_ros//thirdparty:setup_01.bzl", "setup_01")

setup_01()

load("@rules_ros//thirdparty:setup_02.bzl", "setup_02")

setup_02()

load("@rules_ros//thirdparty:setup_03.bzl", "setup_03")

setup_03()

load("@rules_ros//thirdparty:setup_04.bzl", "setup_04")

setup_04()
