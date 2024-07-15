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

load(":providers.bzl", "MsgsInfo")

def _msgs_library_with_cc_impl(ctx):
    cc_info = cc_common.merge_cc_infos(cc_infos = [dep[CcInfo] for dep in ctx.attr.deps])
    msgs_info = ctx.attr.msgs[MsgsInfo]
    return [cc_info, msgs_info]

msgs_library_with_cc = rule(
    implementation = _msgs_library_with_cc_impl,
    attrs = {
        "deps": attr.label_list(providers = [CcInfo]),
        "msgs": attr.label(providers = [MsgsInfo]),
    },
    fragments = ["cpp"],
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
    doc = """
       Rule that provides two providers:
           * a MsgsInfo provider containing all idl_srcs and transitive
             dependencies
           * a CcInfo provider including all transitive dependencies
    """,
)
