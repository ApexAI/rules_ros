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

load("@python_deps//:requirements.bzl", "requirement")

py_library(
    name = "rosidl_cmake_python",
    srcs = [
        "rosidl_cmake/__init__.py",
    ],
    imports = ["."],
    visibility = ["//visibility:public"],
    deps = [
        "//rosidl_parser:rosidl_parser_python",
        requirement("empy"),
    ],
)
