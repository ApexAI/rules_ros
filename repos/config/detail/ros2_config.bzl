load("@bazel_tools//tools/build_defs/repo:utils.bzl", "update_attrs")

BUILD_FILE_CONTENT = """
alias(name = 'ros2.lock', actual = '@rules_ros//repos/config:ros2_humble.lock')",
"""

_archive_attrs = {
    "repo_index": attr.label(
        doc = "YAML file containing the details of every ros2 repository.",
    ),
    "repo_index_overlays": attr.label_list(
        default = [],
        doc = """
            Additional YAML files used as overlays for `repo_index` e.g. to declare BUILD files
            for a repo.
        """,
    ),
    "_generate_ros2_config": attr.label(
        default = "generate_ros2_config.py",
    ),
    "verbose": attr.bool(
        default = False,
        doc = "Prints the calling sequence to stdout.",
    ),
}

def _ros2_config_impl(ctx):

    result = ctx.execute(
        [ctx.attr._generate_ros2_config, ctx.attr.repo_index] +
        ctx.attr.repo_index_overlays
    )
    if result.return_code != 0:
        fail(result.stderr)

    ctx.file("setup.bzl", content = result.stdout)
    ctx.file("repos_lock_file.bzl", content = "REPOS_LOCK_FILE = '{}'".format(ctx.attr.repo_index))
    ctx.file("WORKSPACE", content = "workspace(name = {}".format(ctx.name), executable = False)
    ctx.file("BUILD", executable = False)

    return update_attrs(ctx.attr, _archive_attrs.keys(), {})

ros2_config = repository_rule(
    implementation = _ros2_config_impl,
    attrs = _archive_attrs,
)


