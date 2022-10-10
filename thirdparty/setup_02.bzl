load("@rules_ros//thirdparty/python:setup_toolchain.bzl", "register_python_toolchain")
load("@rules_ros//thirdparty/bazel_skylib:setup.bzl", "setup_bazel_skylib_repositories")
load("@rules_ros//thirdparty/rules_pkg:setup.bzl", "setup_rules_pkg_repositories")

def setup_02():
    register_python_toolchain()
    setup_bazel_skylib_repositories()
    setup_rules_pkg_repositories()
