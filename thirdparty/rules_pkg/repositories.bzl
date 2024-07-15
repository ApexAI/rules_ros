load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

RULES_PKG_VERSION = struct(
    version = "0.10.1",
    sha256 = "d250924a2ecc5176808fc4c25d5cf5e9e79e6346d79d5ab1c493e289e722d1d0",
)

def load_rules_pkg_repositories():
    maybe(
        name = "rules_pkg",
        repo_rule = http_archive,
        urls = [
            "https://github.com/bazelbuild/rules_pkg/releases/download/{version}/rules_pkg-{version}.tar.gz".format(
                version = RULES_PKG_VERSION.version,
            ),
        ],
        sha256 = RULES_PKG_VERSION.sha256,
    )
