load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

BAZEL_SKYLIB_VERSION = "1.3.0"
BAZEL_SKYLIB_SHA = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506"

def load_bazel_skylib_repositories():
    maybe(
        name = "bazel_skylib",
        repo_rule = http_archive,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(
                version = BAZEL_SKYLIB_VERSION,
            ),
            "https://github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(
                version = BAZEL_SKYLIB_VERSION,
            ),
        ],
        sha256 = BAZEL_SKYLIB_SHA,
    )
