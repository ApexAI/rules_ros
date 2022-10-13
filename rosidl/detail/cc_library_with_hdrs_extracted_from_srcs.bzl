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

def _filtered_filegroup_impl(ctx):
    return [DefaultInfo(
        files = depset([f for f in ctx.files.files_to_filter if f.extension in ctx.attr.suffixes]),
    )]

_filtered_filegroup = rule(
    implementation = _filtered_filegroup_impl,
    attrs = {
        "files_to_filter": attr.label_list(
            mandatory = True,
            allow_files = True,
        ),
        "suffixes": attr.string_list(
            mandatory = True,
        ),
    },
)

def cc_library_with_hdrs_extracted_from_srcs(*, name, srcs, **kwargs):
    _filtered_filegroup(
        name = "_%s_hdrs" % name,
        visibility = ["//visibility:private"],
        files_to_filter = srcs,
        suffixes = ["h", "hh", "hpp", "hxx", "inc", "inl", "H"],
    )
    native.cc_library(
        name = name,
        srcs = srcs,
        hdrs = [":_%s_hdrs" % name],
        **kwargs
    )
