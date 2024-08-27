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

load("@rules_ros//repos/config/detail:ros2_config.bzl", "ros2_config")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_ros//repos/config:distros.bzl", "DISTROS")

def _configure_ros2(*, name, distro_src, repos_index_overlays):
    distro_src_wo_setup_file = {k: v for k, v in distro_src.items() if k != "setup_file"}
    distro_src_wo_setup_file["build_file_content"] = 'exports_files(["ros2.repos"])'

    maybe(name = "ros2", **distro_src_wo_setup_file)

    ros2_config(
        name = name,
        repos_index = "@ros2//:ros2.repos",
        repos_index_overlays = [
            "@rules_ros//repos/config:bazel.repos",
        ] + repos_index_overlays,
        setup_file = distro_src["setup_file"],
    )

def configure_ros2(*, name = "ros2_config", repos_index_overlays = [], distro):
    """Configure ROS 2 repositories based on the given distro name."""

    if type(distro) == type(""):
        if not distro in DISTROS:
            fail("Distro {} is not supported. Choose one of {}".format(distro, DISTROS.keys()))
        distro_src = DISTROS[distro]
    else:
        if not type(distro) == type({}) or not "repo_rule" in distro:
            fail("Distro either needs to be a string (e.g. 'iron') or a dict with arguments for the maybe repo rule")
        distro_src = distro
    if not type(repos_index_overlays) == type([]):
        fail("repos_index_overlays needs to be a list of *.repos files")
    _configure_ros2(name = name, distro_src = distro_src, repos_index_overlays = repos_index_overlays)

def configure_repos(*, name = "ros2_config", repos_index, repos_index_overlays = [], setup_file):
    """Configure ROS 2 repositories based on the custom *.repos file."""

    if not type(repos_index_overlays) == type([]):
        fail("repos_index_overlays needs to be a list of *.repos files")
    ros2_config(
        name = name,
        repos_index = repos_index,
        repos_index_overlays = repos_index_overlays,
        setup_file = setup_file,
    )
