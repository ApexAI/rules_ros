load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

def setup_rules_pkg_repositories():
    rules_pkg_dependencies()
