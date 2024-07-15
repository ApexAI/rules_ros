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

def _expand_template_impl(ctx):
    """Get am .em template and produce a header-only library from the generated file."""
    package_name = ctx.attr.package_name
    template_file = ctx.file.template
    if not template_file.basename.endswith(".em"):
        fail("The template file must end with '.em'")
    if len(ctx.attr.variables)>1:
        fail("More than one variable definition not implemented.")
    variable = ctx.attr.variables.keys()[0] if len(ctx.attr.variables) != 0 else None
    values = ctx.attr.variables[variable] if variable != None else [None]
    outputs = []

    for value in values:
        out_file_basename = ctx.attr.output_pattern.format(**{variable:value}) \
            if ctx.attr.output_pattern != "" \
            else template_file.basename.rsplit(".", 1)[0]
        output_file = ctx.actions.declare_file(
            "include/{package_name}/{file_name}".format(
                package_name = package_name,
                file_name = out_file_basename,
            ),
        )
        args = [output_file.path] + [template_file.path]
        if value != None:
            args.extend(["-D", variable + ' = "' + value + '"'])
        ctx.actions.run(
            inputs = [template_file],
            outputs = [output_file],
            progress_message = "Generating a header from template {}".format(template_file.path),
            executable = ctx.executable.generator_script,
            arguments = args,
        )
        outputs.append(output_file)

    includes_folder = output_file.path.rsplit(package_name, 1)[0]
    return [CcInfo(
        compilation_context = cc_common.create_compilation_context(
            includes = depset([includes_folder]),
            headers = depset(outputs),
        ),
    )]

cc_library_from_template = rule(
    implementation = _expand_template_impl,
    output_to_genfiles = True,
    attrs = {
        "package_name": attr.string(
            doc = "Name of the ROS package.",
        ),
        "template": attr.label(
            mandatory = True,
            allow_single_file = [".em"],
            doc = "Input file that will be used to generate the output file.",
        ),
        "output_pattern": attr.string(
            mandatory = False,
            default = "",
        ),
        "variables": attr.string_list_dict(
            mandatory = False,
            doc = "Variables, that will be used for looping through the template expansion.",
            default = {},
        ),
        "generator_script": attr.label(
            mandatory = True,
            executable = True,
            cfg = "exec",
            doc = "A generator script used to generate the output C++ file from the template one.",
        ),
    },
)
