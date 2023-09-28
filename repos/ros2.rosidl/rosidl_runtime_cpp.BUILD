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

cc_library(
    name = "rosidl_runtime_cpp",
    srcs = [],
    hdrs = glob([
        "include/rosidl_runtime_cpp/*.hpp",
        "include/rosidl_typesupport_cpp/*.hpp",
    ]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
    deps = [
        # "//apex_os/core/dds_typesupport",
    ],
)
