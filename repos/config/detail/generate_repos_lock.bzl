load("@python_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary")

def generate_repos_lock(*, name, repos_file, setup_file, overlay_files):
    """Macro to create a py_binary for generating repos_lock.update"""

    py_binary(
        name = name,
        srcs = [Label("lock_repos.py"), Label("generate_ros2_config.py")],
        main = Label("lock_repos.py"),
        data = [repos_file, setup_file] + overlay_files,
        args = [
            "$(execpath {})".format(repos_file),
            "$(execpath {})".format(setup_file),
        ] + ["$(execpath {})".format(f) for f in overlay_files],
        deps = [requirement("pyyaml")],
        visibility = ["//visibility:public"],
    )
