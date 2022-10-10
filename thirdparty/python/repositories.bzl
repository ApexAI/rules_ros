load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

PYTHON_VERSION = "3.8.13"
RULES_PYTHON_VERSION = "0.12.0"
RULES_PYTHON_SHA = "b593d13bb43c94ce94b483c2858e53a9b811f6f10e1e0eedc61073bd90e58d9c"

def load_rules_python_repositories():
    maybe(
        name = "rules_python",
        repo_rule = http_archive,
        url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/{version}.tar.gz".format(
            version = RULES_PYTHON_VERSION,
        ),
        sha256 = RULES_PYTHON_SHA,
        strip_prefix = "rules_python-{version}".format(version = RULES_PYTHON_VERSION),
    )
