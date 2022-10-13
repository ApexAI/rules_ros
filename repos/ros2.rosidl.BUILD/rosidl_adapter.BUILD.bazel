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
    name = "rosidl_adapter",
    srcs = glob([
        "rosidl_adapter/**/*.py",
        "rosidl_adapter/*.py",
    ]),
    data = glob(["rosidl_adapter/resource/*.idl.em"]),
    imports = ["."],
    visibility = ["//visibility:public"],
    deps = [
        "//rosidl_cli",
        requirement("catkin_pkg"),
        requirement("empy"),
    ],
)

py_binary(
    name = "msg2idl",
    srcs = ["scripts/msg2idl.py"],
    legacy_create_init = 0,  # required for py_binaries used on execution platform
    visibility = ["//visibility:public"],
    deps = [":rosidl_adapter"],
)

py_binary(
    name = "srv2idl",
    srcs = ["scripts/srv2idl.py"],
    legacy_create_init = 0,  # required for py_binaries used on execution platform
    visibility = ["//visibility:public"],
    deps = [":rosidl_adapter"],
)

py_test(
    name = "test_base_type",
    srcs = [
        "test/test_base_type.py",
    ],
    deps = [
        ":rosidl_adapter",
        requirement("pytest"),
    ],
)
