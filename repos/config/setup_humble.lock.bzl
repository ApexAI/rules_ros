#
# DO NOT EDIT THIS FILE MANUALLY!
#
# To update, call `bazel run @rules_ros//repos/config:repos_lock.update` with the right distro set in the WORKSPACE
#
# SHA256 of external/ros2/ros2.repos: 09a14ede568810d8120e3f3228af03a35c192cff5c718422cb2d88c5cd4b2824

load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
load("@rules_ros//repos/config/detail:git_repository.bzl", "git_repository")
load("@rules_ros//repos/config/detail:http_archive.bzl", "http_archive")
load("@rules_ros//repos/config/detail:new_local_repository.bzl", "new_local_repository")

def setup():
    pass

    _maybe(
        name = "ament.ament_index",
        branch = "1.4.0",
        build_files = {
            "@rules_ros//repos:ament.ament_index/ament_index_cpp.BUILD": "ament_index_cpp/BUILD.bazel",
            "@rules_ros//repos:ament.ament_index/ament_index_python.BUILD": "ament_index_python/BUILD.bazel",
        },
        commit = "f019d6c40991799a13b18c9c3dcc583e3fde0381",
        remote = "https://github.com/ament/ament_index.git",
        repo_rule = git_repository,
        shallow_since = "1646168510 +0000",
    )

    _maybe(
        name = "eProsima.Fast-CDR",
        branch = "v1.0.24",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "da2987299ee3104bb0393cf0afc8aad6fb848dc1",
        remote = "https://github.com/eProsima/Fast-CDR.git",
        repo_rule = git_repository,
        shallow_since = "1647345218 +0100",
    )

    _maybe(
        name = "eProsima.Fast-DDS",
        branch = "v2.6.6",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "cffaa679ec8cd9c84b4d5b3fe1e3c22974d63be0",
        remote = "https://github.com/eProsima/Fast-DDS.git",
        repo_rule = git_repository,
        shallow_since = "1691144938 +0200",
    )

    _maybe(
        name = "eProsima.foonathan_memory_vendor",
        branch = "v1.3.1",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "e91681a25711c1811b2eaf2ba1e6996e0d9ecc84",
        remote = "https://github.com/eProsima/foonathan_memory_vendor.git",
        repo_rule = git_repository,
        shallow_since = "1683727792 +0200",
    )

    _maybe(
        name = "eclipse-cyclonedds.cyclonedds",
        branch = "0.10.3",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "63b6eab0e0660009eaf5e54d10509ea587ce199e",
        remote = "https://github.com/eclipse-cyclonedds/cyclonedds.git",
        repo_rule = git_repository,
        shallow_since = "1679487279 +0100",
    )

    _maybe(
        name = "eclipse-iceoryx.iceoryx",
        branch = "v2.0.3",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "40ef24e9515940564af63987234d51dc7f02f6b3",
        remote = "https://github.com/eclipse-iceoryx/iceoryx.git",
        repo_rule = git_repository,
        shallow_since = "1675094707 +0100",
    )

    _maybe(
        name = "ros-tooling.libstatistics_collector",
        branch = "1.3.1",
        build_files = {
            "@rules_ros//repos:ros-tooling.libstatistics_collector/root.BUILD": "BUILD.bazel",
        },
        commit = "6d473eb7533a3db385512d5721e3a46ceb06f96f",
        remote = "https://github.com/ros-tooling/libstatistics_collector.git",
        repo_rule = git_repository,
        shallow_since = "1677042096 -0800",
    )

    _maybe(
        name = "ros2.common_interfaces",
        branch = "4.2.3",
        build_files = {
            "@rules_ros//repos:ros2.common_interfaces/std_msgs.BUILD": "std_msgs/BUILD.bazel",
        },
        commit = "f4eac72f0bbd70f7955a5f709d4a6705eb6ca7e8",
        remote = "https://github.com/ros2/common_interfaces.git",
        repo_rule = git_repository,
        shallow_since = "1673281597 -0600",
    )

    _maybe(
        name = "ros2.rcl",
        branch = "5.3.5",
        build_files = {
            "@rules_ros//repos:ros2.rcl/rcl.BUILD": "rcl/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl/rcl_yaml_param_parser.BUILD": "rcl_yaml_param_parser/BUILD.bazel",
        },
        commit = "3804c35f6dd31d5ac54a1acb426bff253cce8272",
        remote = "https://github.com/ros2/rcl.git",
        repo_rule = git_repository,
        shallow_since = "1695130701 +0000",
    )

    _maybe(
        name = "ros2.rcl_interfaces",
        branch = "1.2.1",
        build_files = {
            "@rules_ros//repos:ros2.rcl_interfaces/rcl_interfaces.BUILD": "rcl_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/rosgraph_msgs.BUILD": "rosgraph_msgs/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/builtin_interfaces.BUILD": "builtin_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/statistics_msgs.BUILD": "statistics_msgs/BUILD.bazel",
        },
        commit = "5e01a28f9866a564491480e12d8659a134678741",
        remote = "https://github.com/ros2/rcl_interfaces.git",
        repo_rule = git_repository,
        shallow_since = "1667833699 -0600",
    )

    _maybe(
        name = "ros2.rcl_logging",
        branch = "2.3.1",
        build_files = {
            "@rules_ros//repos:ros2.rcl_logging/rcl_logging_interface.BUILD": "rcl_logging_interface/BUILD.bazel",
        },
        commit = "1b7a4e34884005f28eeb04065b5d94565c67b11d",
        remote = "https://github.com/ros2/rcl_logging.git",
        repo_rule = git_repository,
        shallow_since = "1667833800 -0600",
    )

    _maybe(
        name = "ros2.rclcpp",
        branch = "16.0.6",
        build_files = {
            "@rules_ros//repos:ros2.rclcpp/build_interfaces.py": "rclcpp/build_interfaces.py",
            "@rules_ros//repos:ros2.rclcpp/rclcpp.BUILD": "rclcpp/BUILD.bazel",
        },
        commit = "0f6b5449f66f131735a423be4a84d6f14751d3b2",
        remote = "https://github.com/ros2/rclcpp.git",
        repo_rule = git_repository,
        shallow_since = "1695130763 +0000",
    )

    _maybe(
        name = "ros2.rcpputils",
        branch = "2.4.1",
        build_files = {
            "@rules_ros//repos:ros2.rcpputils/rcpputils.BUILD": "BUILD.bazel",
        },
        commit = "3eb281afdc891855b5feb367c79ede1e2fbb0acb",
        remote = "https://github.com/ros2/rcpputils.git",
        repo_rule = git_repository,
        shallow_since = "1682457603 +0000",
    )

    _maybe(
        name = "ros2.rcutils",
        branch = "5.1.3",
        build_files = {
            "@rules_ros//repos:ros2.rcutils/root.BUILD": "BUILD.bazel",
            "@rules_ros//repos:ros2.rcutils/build_logging_macros.py": "build_logging_macros.py",
        },
        commit = "2d9d74e72ecd1eea240412be3dacd413dcb5f680",
        remote = "https://github.com/ros2/rcutils.git",
        repo_rule = git_repository,
        shallow_since = "1682457695 +0000",
    )

    _maybe(
        name = "ros2.rmw",
        branch = "6.1.1",
        build_files = {
            "@rules_ros//repos:ros2.rmw/rmw.BUILD": "rmw/BUILD.bazel",
        },
        commit = "2a4ee718d0da004d5629f50afd2896fbd1f4aedd",
        remote = "https://github.com/ros2/rmw.git",
        repo_rule = git_repository,
        shallow_since = "1667834517 -0600",
    )

    _maybe(
        name = "ros2.ros2_tracing",
        branch = "4.1.1",
        build_files = {
            "@rules_ros//repos:ros2.ros2_tracing/tracetools.BUILD": "tracetools/BUILD.bazel",
        },
        commit = "548634dd2837d65c043436c8186614e924be5c6c",
        remote = "https://github.com/ros2/ros2_tracing.git",
        repo_rule = git_repository,
        shallow_since = "1667834775 -0600",
    )

    _maybe(
        name = "ros2.ros2cli",
        branch = "0.18.7",
        build_files = {
            "@rules_ros//repos:ros2.ros2cli/ros2cli.BUILD": "ros2cli/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2pkg.BUILD": "ros2pkg/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2run.BUILD": "ros2run/BUILD.bazel",
        },
        commit = "38d4fa97fa8091e211e190d70e9fa0b0e817689d",
        remote = "https://github.com/ros2/ros2cli.git",
        repo_rule = git_repository,
        shallow_since = "1689700836 +0000",
    )

    _maybe(
        name = "ros2.rosidl",
        branch = "3.1.5",
        build_files = {
            "@rules_ros//repos:ros2.rosidl/rosidl_runtime_c.BUILD": "rosidl_runtime_c/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_runtime_cpp.BUILD": "rosidl_runtime_cpp/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_adapter.BUILD": "rosidl_adapter/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_cli.BUILD": "rosidl_cli/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_parser.BUILD": "rosidl_parser/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_cmake.BUILD": "rosidl_cmake/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_typesupport_interface.BUILD": "rosidl_typesupport_interface/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_generator_c.BUILD": "rosidl_generator_c/BUILD.bazel",
            "@rules_ros//repos:ros2.rosidl/rosidl_generator_cpp.BUILD": "rosidl_generator_cpp/BUILD.bazel",
        },
        commit = "cf3b637605c8c1dc0b1266ca0090963e9186c7dd",
        remote = "https://github.com/ros2/rosidl.git",
        repo_rule = git_repository,
        shallow_since = "1689702714 +0000",
    )

    _maybe(
        name = "ros2.rosidl_dds",
        branch = "0.8.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_dds/rosidl_generator_dds_idl.BUILD": "rosidl_generator_dds_idl/BUILD.bazel",
        },
        commit = "ab8497770c652edb40d6b1591118198cbcf14237",
        remote = "https://github.com/ros2/rosidl_dds.git",
        repo_rule = git_repository,
        shallow_since = "1648665003 -0700",
    )

    _maybe(
        name = "ros2.rosidl_typesupport",
        branch = "2.0.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_typesupport/rosidl_typesupport_c.BUILD": "rosidl_typesupport_c/BUILD.bazel",
        },
        commit = "aa522c4bf1a1b6c10766b84ca6625a8c494c0928",
        remote = "https://github.com/ros2/rosidl_typesupport.git",
        repo_rule = git_repository,
        shallow_since = "1689702809 +0000",
    )
