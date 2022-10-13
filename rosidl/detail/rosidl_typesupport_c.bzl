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
load(":detail/visiability_control.bzl", "create_visibility_control_h")
load(":detail/cc_library_with_hdrs_extracted_from_srcs.bzl", "cc_library_with_hdrs_extracted_from_srcs")

def output_files_create(name):
    snake_case_name = to_snake_case_with_exceptions(name)
    return [
        snake_case_name + "__type_support" + ".cpp",
    ]

def _rosidl_typesupport_c_impl(ctx):
    # Step 1: Configure
    cfg = create_common_config(
        ctx,
        srcs = ctx.files.srcs,
        output_file_create_func = output_files_create,
    )

    # Step 2: Write config file
    _config = {
        "package_name": cfg.package_name,
        "output_dir": cfg.output_dir,
        "template_dir": extract_single_dirname(ctx.files._generator_resources),
        "idl_tuples": cfg.idl_tuples,
        "target_dependencies": [],
    }
    arguments_json_file = ctx.actions.declare_file("rosidl_typesupport_c__arguments.json")
    ctx.actions.write(
        output = arguments_json_file,
        content = json.encode_indent(_config, indent = "  "),
    )

    # Step 3: Run rosidl_generator_c
    args = ctx.actions.args()
    args.add("--generator-arguments-file", arguments_json_file.path)
    if len(ctx.attr.typesupports) < 1:
        fail("Typesupports may not be an empty list")
    args.add("--typesupports")
    for rmw in ctx.attr.typesupports:
        args.add(rmw)
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

_rosidl_typesupport_c = rule(
    implementation = _rosidl_typesupport_c_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".idl"]),
        "_generator": attr.label(
            default = "@ros2.rosidl_typesupport//rosidl_typesupport_c:generator",
            executable = True,
            cfg = "exec",
            doc = "A generator used to actually generate",
        ),
        "_generator_resources": attr.label_list(
            default = [
                "@ros2.rosidl_typesupport//rosidl_typesupport_c:resource",
            ],
            cfg = "exec",
        ),
        "_visibility_control_h_in": attr.label(
            default = "@ros2.rosidl_typesupport//rosidl_typesupport_c:resource/rosidl_typesupport_c__visibility_control.h.in",
            allow_single_file = True,
        ),
        "typesupports": attr.string_list(
            mandatory = True,
            doc = "Typesupports that are required to generate the messages.",
        ),
    },
)

def cc_rosidl_typesupport_c_library(*, name, srcs, typesupports, **kwargs):
    _rosidl_typesupport_c(
        name = "_%s_files" % name,
        srcs = srcs,
        typesupports = typesupports,
    )
    cc_library_with_hdrs_extracted_from_srcs(
        name = name,
        srcs = [":_%s_files" % name],
        strip_include_prefix = ".",
        **kwargs
    )
