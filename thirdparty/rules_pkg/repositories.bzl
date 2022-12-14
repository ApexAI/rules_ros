load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

RULES_PKG_VERSION = "0.7.0"
RULES_PKG_SHA = "8a298e832762eda1830597d64fe7db58178aa84cd5926d76d5b744d6558941c2"

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
