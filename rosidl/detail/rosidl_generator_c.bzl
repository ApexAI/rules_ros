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

load(":detail/misc_support.bzl", "extract_single_dirname", "to_snake_case_with_exceptions")
load(":detail/common_config.bzl", "create_common_config")
load(":detail/visiability_control.bzl", "create_visibility_control_h")
load(":detail/cc_library_with_hdrs_extracted_from_srcs.bzl", "cc_library_with_hdrs_extracted_from_srcs")
load(":providers.bzl", "MsgsInfo")

_default_attrs = {
    "_generator": attr.label(
        default = "@ros2.rosidl//rosidl_generator_c:generator",
        executable = True,
        cfg = "exec",
        doc = "A generator used to actually generate",
    ),
    "_generator_resources": attr.label_list(
        default = [
            "@ros2.rosidl//rosidl_generator_c:resource",
        ],
        cfg = "exec",
    ),
   "_visibility_control_h_in": attr.label(
       default = "@ros2.rosidl//rosidl_generator_c:resource/rosidl_generator_c__visibility_control.h.in",
       allow_single_file = True,
   ),
}

def _dict_union(x, y):
    z = {}
    z.update(x)
    z.update(y)
    return z

def _output_files_create(name):
    snake_case_name = to_snake_case_with_exceptions(name)
    return [
        snake_case_name + "" + ".h",
        "detail/" + snake_case_name + "__struct" + ".h",
        "detail/" + snake_case_name + "__type_support" + ".h",
        "detail/" + snake_case_name + "__functions" + ".h",
        "detail/" + snake_case_name + "__functions" + ".c",
    ]

def _build_generator_c_files(ctx, srcs):
    # Step 1: Configure
    cfg = create_common_config(
        ctx,
        srcs = srcs,
        output_file_create_func = _output_files_create,
    )

    # Step 2: Write config file
    _config = {
        "package_name": cfg.package_name,
        "output_dir": cfg.output_dir,
        "template_dir": extract_single_dirname(ctx.files._generator_resources),
        "idl_tuples": cfg.idl_tuples,
        "target_dependencies": [],
    }
    arguments_json_file = ctx.actions.declare_file("rosidl_generator_c__arguments.json")
    ctx.actions.write(
        output = arguments_json_file,
        content = json.encode_indent(_config, indent = "  "),
    )

    # Step 3: Run rosidl_generator_c
    args = ctx.actions.args()
    args.add("--generator-arguments-file", arguments_json_file.path)
    ctx.actions.run(
        executable = ctx.executable._generator,
        arguments = [args],
        inputs = srcs + [arguments_json_file],
        tools = ctx.files._generator_resources,
        outputs = cfg.outputs,
    )

    # Step 4: Add visibility control file
    create_visibility_control_h(
        ctx,
        cfg,
        output_filename = "rosidl_generator_c__visibility_control.h",
    )
    return cfg.outputs

def _rosidl_generator_c_impl(ctx):
    outputs = _build_generator_c_files(ctx, ctx.files.srcs)
    return [
        DefaultInfo(files = depset(direct = outputs)),
    ]

_rosidl_generator_c = rule(
    implementation = _rosidl_generator_c_impl,
    attrs = _dict_union(_default_attrs, {"srcs": attr.label_list(allow_files = [".idl"])}),
)

def _rosidl_generator_c_aspect_impl(target, ctx):
    outputs = _build_generator_c_files(ctx, target[OutputGroupInfo].rosidl_generator_dds_idl.to_list())
    return [
        DefaultInfo(files = depset(direct = outputs)),
    ]

rosidl_generator_c_aspect = aspect(
    implementation = _rosidl_generator_c_aspect_impl,
    attrs = _default_attrs,
    required_providers = [MsgsInfo],
    attr_aspects = ["deps"],
)

def cc_rosidl_generator_c_library(*, name, srcs, **kwargs):
    _rosidl_generator_c(
        name = "_%s_files" % name,
        srcs = srcs,
    )
    cc_library_with_hdrs_extracted_from_srcs(
        name = name,
        srcs = [":_%s_files" % name],
        strip_include_prefix = ".",
        **kwargs
    )
