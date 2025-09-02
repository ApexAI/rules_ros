load(":defs.bzl", "configure_ros2")

def _ros2_config_impl(module_ctx):
    print((module_ctx.modules[0].name))
    for mod in module_ctx.modules:
        for config in mod.tags.config:
            configure_ros2(name = config.name, distro = config.distro)

_distro_config = tag_class(
    attrs = {
        "name": attr.string(),
        "distro": attr.string(),
    },
)

ros2_config = module_extension(
    implementation = _ros2_config_impl,
    tag_classes = {"config": _distro_config},
)
