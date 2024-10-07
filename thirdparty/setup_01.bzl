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

load("@rules_ros//thirdparty/bazel_skylib:repositories.bzl", "load_bazel_skylib_repositories")
load("@rules_ros//thirdparty/libyaml:repositories.bzl", "load_libyaml_repositories")
load("@rules_ros//thirdparty/python:repositories.bzl", "load_rules_python_repositories")
load("@rules_ros//thirdparty/rules_pkg:repositories.bzl", "load_rules_pkg_repositories")

def setup_01():
    load_rules_python_repositories()
    load_libyaml_repositories()
    load_bazel_skylib_repositories()
    load_rules_pkg_repositories()
