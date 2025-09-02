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

load("@rules_ros//thirdparty/bazel_skylib:setup.bzl", "setup_bazel_skylib_repositories")
load("@rules_ros//thirdparty/python:setup.bzl", "setup_rules_python_repositories")
load("@rules_ros//thirdparty/rules_pkg:setup.bzl", "setup_rules_pkg_repositories")

def setup_02():
    setup_rules_python_repositories()
    setup_bazel_skylib_repositories()
    setup_rules_pkg_repositories()
