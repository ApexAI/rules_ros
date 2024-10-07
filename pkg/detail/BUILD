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

load("@python_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary")

exports_files(["templates/install.template"])

py_binary(
    name = "package_xml.generate",
    srcs = ["package_xml_generator.py"],
    main = "package_xml_generator.py",
    visibility = ["//visibility:public"],
    deps = [
        requirement("jinja2"),
    ],
)

py_binary(
    name = "executable_wrapper.generate",
    srcs = ["executable_wrapper_generator.py"],
    main = "executable_wrapper_generator.py",
    visibility = ["//visibility:public"],
)

py_binary(
    name = "setup_bash.generate",
    srcs = ["setup_bash_generator.py"],
    main = "setup_bash_generator.py",
    visibility = ["//visibility:public"],
)
