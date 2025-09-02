load("@rules_python//python:pip.bzl", _pip_parse = "pip_parse")

def pip_parse():
    _pip_parse(
        name = "python_deps",
        python_interpreter_target = "@python_interpreter_host//:python",
        requirements_lock = "@rules_ros//thirdparty/python:requirements_lock.txt",
    )
