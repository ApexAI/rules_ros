load("//repos/config:setup_humble.lock.bzl", "setup")

def _ros_repos_impl(module_ctx):
    setup()

ros_repos = module_extension(
    implementation = _ros_repos_impl,
)
