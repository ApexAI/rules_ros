load("@python_deps//:requirements.bzl", "requirement")
load("@ros2_config//:repos_index_file.bzl", "REPOS_INDEX_FILE")
load("@ros2_config//:repos_overlay_files.bzl", "REPOS_OVERLAY_FILES")
load("@ros2_config//:repos_setup_file.bzl", "REPOS_SETUP_FILE")
load("@rules_python//python:defs.bzl", "py_binary")

def generate_repos_lock(name, repos_file, setup_file, overlay_files):
    """Macro to create a py_binary for generating repos_lock.update"""

    py_binary(
        name = name,
        srcs = ["lock_repos.py", "generate_ros2_config.py"],
        main = "lock_repos.py",
        data = [REPOS_INDEX_FILE, REPOS_SETUP_FILE] + REPOS_OVERLAY_FILES,
        args = [
            "$(execpath {})".format(REPOS_INDEX_FILE),
            "$(execpath {})".format(REPOS_SETUP_FILE),
        ] + ["$(execpath {})".format(f) for f in REPOS_OVERLAY_FILES],
        deps = [requirement("pyyaml")],
        visibility = ["//visibility:public"],
    )