load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

LIBYAML_VERSION = "0.2.5"
LIBYAML_SHA = "45ec4bc54856a45e9815c897f8f7236c541b7673e18d49504335ece464aa02cc"

def load_libyaml_repositories():
    maybe(
        name = "libyaml",
        repo_rule = http_archive,
        urls = ["https://github.com/yaml/libyaml/releases/download/{version}/yaml-{version}.zip".format(version = LIBYAML_VERSION)],
        sha256 = LIBYAML_SHA,
        strip_prefix = "yaml-{version}".format(version = LIBYAML_VERSION),
        build_file = "@rules_ros//thirdparty/libyaml:libyaml.BUILD",
    )
