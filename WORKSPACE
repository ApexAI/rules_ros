workspace(name = "rules_ros")

load("//repos/config:defs.bzl", "configure_ros2")

configure_ros2(distro = "humble")

load("@ros2_config//:setup.bzl", "setup")

setup()

load("@rules_ros//thirdparty:setup_01.bzl", "setup_01")

setup_01()

load("@rules_ros//thirdparty:setup_02.bzl", "setup_02")

setup_02()

load("@rules_ros//thirdparty:setup_03.bzl", "setup_03")

setup_03()

load("@rules_ros//thirdparty:setup_04.bzl", "setup_04")

setup_04()
