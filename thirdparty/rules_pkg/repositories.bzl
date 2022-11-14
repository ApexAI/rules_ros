load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

RULES_PKG_VERSION = "0.8.0"
RULES_PKG_SHA = "eea0f59c28a9241156a47d7a8e32db9122f3d50b505fae0f33de6ce4d9b61834"

def load_rules_pkg_repositories():
    maybe(
        name = "rules_pkg",
        repo_rule = http_archive,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/{version}/rules_pkg-{version}.tar.gz".format(version = RULES_PKG_VERSION),
            "https://github.com/bazelbuild/rules_pkg/releases/download/{version}/rules_pkg-{version}.tar.gz".format(version = RULES_PKG_VERSION),
        ],
        sha256 = RULES_PKG_SHA,
    )
