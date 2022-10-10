def _expand_template_impl(ctx):
    """Get am .em template and produce a header-only library from the generated file."""
    package_name = ctx.attr.package_name
    template_file = ctx.file.template
    if not template_file.basename.endswith(".em"):
        fail("The template file must end with '.em'")
    out_file_basename = template_file.basename.rsplit(".", 1)[0]
    output_file = ctx.actions.declare_file(
        "include/{package_name}/{file_name}".format(
            package_name = package_name,
            file_name = out_file_basename,
        ),
    )
    args = [output_file.path] + [template_file.path]
    ctx.actions.run(
        inputs = [template_file],
        outputs = [output_file],
        progress_message = "Generating a header from template {}".format(template_file.path),
        executable = ctx.executable.generator_script,
        arguments = args,
    )
    includes_folder = output_file.path.rsplit(package_name, 1)[0]
    return [CcInfo(
        compilation_context = cc_common.create_compilation_context(
            includes = depset([includes_folder]),
            headers = depset([output_file]),
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
        "generator_script": attr.label(
            mandatory = True,
            executable = True,
            cfg = "exec",
            doc = "A generator script used to generate the output C++ file from the template one.",
        ),
    },
)
