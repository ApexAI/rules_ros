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

load(":detail/misc_support.bzl", "extract_single_dirname", "to_snake_case_with_exceptions")
load(":detail/common_config.bzl", "create_common_config")
load(":detail/cc_library_with_hdrs_extracted_from_srcs.bzl", "cc_library_with_hdrs_extracted_from_srcs")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def output_files_create(name):
    snake_case_name = to_snake_case_with_exceptions(name)
    return [
        snake_case_name + ".hpp",
        "detail/" + snake_case_name + "__builder" + ".hpp",
        "detail/" + snake_case_name + "__struct" + ".hpp",
        "detail/" + snake_case_name + "__traits" + ".hpp",
    ]

def _rosidl_generator_cpp_impl(ctx):
    # Step 1: Configure
    cfg = create_common_config(
        ctx,
        srcs = ctx.files.srcs,
        output_file_create_func = lambda name: output_files_create(name),
    )

    # Step 2: Write config file
    _config = {
        "package_name": cfg.package_name,
        "output_dir": cfg.output_dir,
        "template_dir": extract_single_dirname(ctx.files._generator_resources),
        "idl_tuples": cfg.idl_tuples,
        "target_dependencies": [],
    }
    arguments_json_file = ctx.actions.declare_file("rosidl_generator_cpp__arguments.json")
    ctx.actions.write(
        output = arguments_json_file,
        content = json.encode_indent(_config, indent = "  "),
    )

    # Step 3: Run rosidl_generator_cpp
    args = ctx.actions.args()
    args.add("--generator-arguments-file", arguments_json_file.path)
    ctx.actions.run(
        executable = ctx.executable._generator,
        arguments = [args],
        inputs = ctx.files.srcs + [arguments_json_file],
        tools = ctx.files._generator_resources,
        outputs = cfg.outputs,
    )

    # Final: Return results
    return [
        DefaultInfo(
            files = depset(direct = cfg.outputs),
        ),
    ]

_rosidl_generator_cpp = rule(
    implementation = _rosidl_generator_cpp_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".idl"]),
        "_generator": attr.label(
            default = "@ros2.rosidl//rosidl_generator_cpp:generator",
            executable = True,
            cfg = "exec",
            doc = "A generator used to actually generate",
        ),
        "_generator_resources": attr.label_list(
            default = [
                "@ros2.rosidl//rosidl_generator_cpp:resource",
            ],
            cfg = "exec",
        ),
    },
)

def cc_rosidl_generator_cpp_library(*, name, srcs, **kwargs):
    _rosidl_generator_cpp(
        name = "_%s_files" % name,
        srcs = srcs,
    )
    cc_library_with_hdrs_extracted_from_srcs(
        name = name,
        srcs = [":_%s_files" % name],
        strip_include_prefix = ".",
        **kwargs
    )
