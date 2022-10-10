load("@rules_python//python:repositories.bzl", "python_register_toolchains")
load("@rules_ros//thirdparty/python:repositories.bzl", "PYTHON_VERSION")

def register_python_toolchain():
    python_register_toolchains(
        name = "python_interpreter",
        # Available versions are listed in @rules_python//python:versions.bzl.
        python_version = PYTHON_VERSION,
    )
