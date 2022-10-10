load("@rules_ros//repos/config/detail:ros2_config.bzl", _ros2_config = "ros2_config")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", _new_git_repository = "new_git_repository")

def _configure_ros2_humble(*, name):

    _maybe(
        name = "ros2",
        repo_rule = _new_git_repository,
        remote = "https://github.com/ros2/ros2.git",
        build_file_content = 'exports_files(["ros2.repos"])',
        commit = "00f3ba9f73916a5eab322710edaaf197f0f10e31",
        shallow_since = "1660330451 -0400",
    )
    _ros2_config(
        name = name,
        repo_index = "@rules_ros//repos/config:ros2_humble.lock",
        repo_index_overlays = [
            "@rules_ros//repos/config:bazel.repos",
        ]
    )

def configure_ros2(*, name = "ros2_config", distro):
    """
    """
    DISTROS = {
        "humble": _configure_ros2_humble,
    }
    if not distro in DISTROS:
        fail("Distro {} is not supported. Choose one of {}".format(distro, DISTROS.keys()))
    DISTROS[distro](name = name)
