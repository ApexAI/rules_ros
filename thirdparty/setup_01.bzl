load("@rules_ros//thirdparty/python:repositories.bzl", "load_rules_python_repositories")
load("@rules_ros//thirdparty/libyaml:repositories.bzl", "load_libyaml_repositories")
load("@rules_ros//thirdparty/bazel_skylib:repositories.bzl", "load_bazel_skylib_repositories")
load("@rules_ros//thirdparty/rules_pkg:repositories.bzl", "load_rules_pkg_repositories")

def setup_01():
    load_rules_python_repositories()
    load_libyaml_repositories()
    load_bazel_skylib_repositories()
    load_rules_pkg_repositories()
