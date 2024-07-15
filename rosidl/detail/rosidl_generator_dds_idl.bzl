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

load(":detail/misc_support.bzl", "extract_single_dirname")
load(":detail/common_config.bzl", "create_common_config_for_dds_idl_generator")
load(":providers.bzl", "MsgsInfo")

_default_attrs = {
    "_generator": attr.label(
        default = "@ros2.rosidl_dds//rosidl_generator_dds_idl:generator",
        executable = True,
        cfg = "exec",
        doc = "A generator used to actually generate the messages.",
    ),
    "_generator_resources": attr.label_list(
        default = [
            "@ros2.rosidl_dds//rosidl_generator_dds_idl:resource",
        ],
        cfg = "exec",
    ),
    "_additional_service_templates": attr.label_list(
        default = [],
        allow_files = [".em"],
        doc = "Sometimes due to how python scripts work they need this additional input.",
    ),
}

def _dict_union(x, y):
    z = {}
    z.update(x)
    z.update(y)
    return z

def _output_files_create(name):
    return [
        "apex_middleware_typefiles" + "/" + name.replace(".idl", "_.idl"),
    ]

def _build_dds_idl_files(ctx, srcs):
    # Step 1: Configure
    cfg = create_common_config_for_dds_idl_generator(
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
    arguments_json_file = ctx.actions.declare_file("rosidl_generator_dds_idl__apex_middleware_typefiles__arguments.json")
    ctx.actions.write(
        output = arguments_json_file,
        content = json.encode_indent(_config, indent = "  "),
    )

    # Step 3: Run rosidl_generator_c
    args = ctx.actions.args()

    args.add("--generator-arguments-file", arguments_json_file.path)
    # args.add("--subfolders", "apex_middleware_typefiles")
    # args.add("--extension", "apex_middleware_typefiles_generator.rosidl_generator_dds_idl_extension")
    if ctx.attr._additional_service_templates:
        args.add("--additional-service-templates")
        for p in ctx.files._additional_service_templates:
            args.add(p.path)
    ctx.actions.run(
        executable = ctx.executable._generator,
        arguments = [args],
        inputs = srcs + ctx.files._additional_service_templates + [arguments_json_file],
        tools = ctx.files._generator_resources,
        outputs = cfg.outputs,
    )

    # Final: Return output files
    return cfg.outputs

def _rosidl_generator_dds_idl_impl(ctx):
    outputs = _build_dds_idl_files(ctx, ctx.files.srcs)
    return [
        DefaultInfo(files = depset(direct = outputs)),
    ]

rosidl_generator_dds_idl = rule(
    implementation = _rosidl_generator_dds_idl_impl,
    attrs = _dict_union(
        _default_attrs,
        {"srcs": attr.label_list(allow_files = [".idl"])},
    ),
)

def _rosidl_generator_dds_idl_aspect_impl(target, ctx):
    outputs = _build_dds_idl_files(ctx, target[MsgsInfo].srcs)
    return [
        OutputGroupInfo(rosidl_generator_dds_idl = outputs),
    ]

rosidl_generator_dds_idl_aspect = aspect(
    implementation = _rosidl_generator_dds_idl_aspect_impl,
    attrs = _default_attrs,
    required_providers = [MsgsInfo],
    attr_aspects = ["deps"],
)
