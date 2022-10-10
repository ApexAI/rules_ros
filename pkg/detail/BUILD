load("@rules_python//python:defs.bzl", "py_binary")
load("@python_deps//:requirements.bzl", "requirement")

exports_files(["templates/install.template"])

py_binary(
    name = "package_xml.generate",
    srcs = ["package_xml_generator.py"],
    main = "package_xml_generator.py",
    visibility = ["//visibility:public"],
    deps = [
        requirement("jinja2"),
    ],
)

py_binary(
    name = "executable_wrapper.generate",
    srcs = ["executable_wrapper_generator.py"],
    main = "executable_wrapper_generator.py",
    visibility = ["//visibility:public"],
)

py_binary(
    name = "setup_bash.generate",
    srcs = ["setup_bash_generator.py"],
    main = "setup_bash_generator.py",
    visibility = ["//visibility:public"],
)
