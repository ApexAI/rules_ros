load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

RULES_PKG_VERSION = struct(
    version = "1.1.0",
    sha256 = "b7215c636f22c1849f1c3142c72f4b954bb12bb8dcf3cbe229ae6e69cc6479db",
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
