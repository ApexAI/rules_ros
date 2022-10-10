cc_library(
    name = "libyaml",
    srcs = glob([
        "src/*.c",
        "src/*.h",
    ]),
    hdrs = glob(["include/*.h"]),
    defines = [
        'YAML_VERSION_STRING=\\\"0.2.5\\\"',
        "YAML_VERSION_MAJOR=0",
        "YAML_VERSION_MINOR=2",
        "YAML_VERSION_PATCH=5",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
)
