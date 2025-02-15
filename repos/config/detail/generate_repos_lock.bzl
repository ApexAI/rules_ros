load("@python_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary")

def repos_lock_updater(*, name, repos_file, setup_file, overlay_files):
    """Executable rule for updating the `setup_file` from a `repos_file` and `overlay_files`."""

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
