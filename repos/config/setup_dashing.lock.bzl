#
# DO NOT EDIT THIS FILE MANUALLY!
#
# To update, call `bazel run @rules_ros//repos/config:repos_lock.update` with the right distro set in the WORKSPACE
#

load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
load("@rules_ros//repos/config/detail:git_repository.bzl", "git_repository")
load("@rules_ros//repos/config/detail:http_archive.bzl", "http_archive")
load("@rules_ros//repos/config/detail:new_local_repository.bzl", "new_local_repository")

def setup():
    pass

    _maybe(
        name = "ament.ament_index",
        branch = "0.7.2",
        build_files = {
            "@rules_ros//repos:ament.ament_index/ament_index_cpp.BUILD": "ament_index_cpp/BUILD.bazel",
            "@rules_ros//repos:ament.ament_index/ament_index_python.BUILD": "ament_index_python/BUILD.bazel",
        },
        commit = "9d42ba13d7694ad8da5b1622e433e691996c4502",
        remote = "https://github.com/ament/ament_index.git",
        repo_rule = git_repository,
        shallow_since = "1571244457 -0700",
    )

    _maybe(
        name = "eclipse-cyclonedds.cyclonedds",
        branch = "0.7.0",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "c261053186c455abc63ca5ac7d56c0808a59c364",
        remote = "https://github.com/eclipse-cyclonedds/cyclonedds.git",
        repo_rule = git_repository,
        shallow_since = "1596471565 +0200",
    )

    _maybe(
        name = "eProsima.Fast-CDR",
        branch = "v1.0.13",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "174f6ff1d3a227c5c900a4587ee32fa888267f5e",
        remote = "https://github.com/eProsima/Fast-CDR.git",
        repo_rule = git_repository,
        shallow_since = "1585310200 +0100",
    )

    _maybe(
        name = "ros2.common_interfaces",
        branch = "0.7.1",
        build_files = {
            "@rules_ros//repos:ros2.common_interfaces/std_msgs.BUILD": "std_msgs/BUILD.bazel",
        },
        commit = "30dbc60b45e22f2c88a4c46493388fdad3916845",
        remote = "https://github.com/ros2/common_interfaces.git",
        repo_rule = git_repository,
        shallow_since = "1621610616 -0700",
    )

    _maybe(
        name = "ros2.rcl",
        branch = "0.7.10",
        build_files = {
            "@rules_ros//repos:ros2.rcl/rcl.BUILD": "rcl/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl/rcl_yaml_param_parser.BUILD": "rcl_yaml_param_parser/BUILD.bazel",
        },
        commit = "f28fd0d5ee8e13a4955dbe84bd336eeee7e2be5d",
        remote = "https://github.com/ros2/rcl.git",
        repo_rule = git_repository,
        shallow_since = "1621608437 -0700",
    )

    _maybe(
        name = "ros2.rcl_interfaces",
        branch = "0.7.4",
        build_files = {
            "@rules_ros//repos:ros2.rcl_interfaces/rcl_interfaces.BUILD": "rcl_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/rosgraph_msgs.BUILD": "rosgraph_msgs/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/builtin_interfaces.BUILD": "builtin_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/statistics_msgs.BUILD": "statistics_msgs/BUILD.bazel",
        },
        commit = "bfa9c43dd7d8cfc5c6fcba8a164d8ef317a386d7",
        remote = "https://github.com/ros2/rcl_interfaces.git",
        repo_rule = git_repository,
        shallow_since = "1559174983 -0700",
    )

    _maybe(
        name = "ros2.rcl_logging",
        branch = "0.2.1",
        build_files = {
            "@rules_ros//repos:ros2.rcl_logging/rcl_logging_interface.BUILD": "rcl_logging_interface/BUILD.bazel",
        },
        commit = "6b1880038fed2893557c931a202c16b974637e42",
        remote = "https://github.com/ros2/rcl_logging.git",
        repo_rule = git_repository,
        shallow_since = "1557360130 -0500",
    )

    _maybe(
        name = "ros2.rclcpp",
        branch = "0.7.16",
        build_files = {
            "@rules_ros//repos:ros2.rclcpp/build_interfaces.py": "rclcpp/build_interfaces.py",
            "@rules_ros//repos:ros2.rclcpp/rclcpp.BUILD": "rclcpp/BUILD.bazel",
        },
        commit = "403aac966271132feadffca93dcfb24f6ab90efb",
        remote = "https://github.com/ros2/rclcpp.git",
        repo_rule = git_repository,
        shallow_since = "1621608557 -0700",
    )

    _maybe(
        name = "ros2.rcpputils",
        branch = "0.1.1",
        build_files = {
            "@rules_ros//repos:ros2.rcpputils/rcpputils.BUILD": "BUILD.bazel",
        },
        commit = "f8e638eb72bfbacea18ca1cf67c4f7d48561d9b2",
        remote = "https://github.com/ros2/rcpputils.git",
        repo_rule = git_repository,
        shallow_since = "1564532092 -0700",
    )

    _maybe(
        name = "ros2.rcutils",
        branch = "0.7.6",
        build_files = {
            "@rules_ros//repos:ros2.rcutils/root.BUILD": "BUILD.bazel",
            "@rules_ros//repos:ros2.rcutils/build_logging_macros.py": "build_logging_macros.py",
        },
        commit = "f868e5cb0eaeb9ae9fc984f6783922f375411007",
        remote = "https://github.com/ros2/rcutils.git",
        repo_rule = git_repository,
        shallow_since = "1606260966 -0800",
    )

    _maybe(
        name = "ros2.rmw",
        branch = "0.7.2",
        build_files = {
            "@rules_ros//repos:ros2.rmw/rmw.BUILD": "rmw/BUILD.bazel",
        },
        commit = "8652949435267cdf0fd65368f621146dea9a85eb",
        remote = "https://github.com/ros2/rmw.git",
        repo_rule = git_repository,
        shallow_since = "1560370615 +0000",
    )

    _maybe(
        name = "ros2.ros2cli",
        branch = "0.7.11",
        build_files = {
            "@rules_ros//repos:ros2.ros2cli/ros2cli.BUILD": "ros2cli/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2pkg.BUILD": "ros2pkg/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2run.BUILD": "ros2run/BUILD.bazel",
        },
        commit = "8ff79e6cfc88a8d973c854a6709404eed6db47e0",
        remote = "https://github.com/ros2/ros2cli.git",
        repo_rule = git_repository,
        shallow_since = "1594441053 -0400",
    )

    _maybe(
        name = "ros2.rosidl",
        branch = "0.7.10",
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
        commit = "407b652ac8ca23beea2f1f24575dd57f0c9b4401",
        remote = "https://github.com/ros2/rosidl.git",
        repo_rule = git_repository,
        shallow_since = "1606259638 -0800",
    )

    _maybe(
        name = "ros2.rosidl_dds",
        branch = "0.7.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_dds/rosidl_generator_dds_idl.BUILD": "rosidl_generator_dds_idl/BUILD.bazel",
        },
        commit = "e88b1d0e62a2dca0788142cf1fb266a3a3c3d7dc",
        remote = "https://github.com/ros2/rosidl_dds.git",
        repo_rule = git_repository,
        shallow_since = "1557357026 -0500",
    )

    _maybe(
        name = "ros2.rosidl_typesupport",
        branch = "0.7.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_typesupport/rosidl_typesupport_c.BUILD": "rosidl_typesupport_c/BUILD.bazel",
        },
        commit = "38eb801f1f856a503676bb79875786b3a3b6d92d",
        remote = "https://github.com/ros2/rosidl_typesupport.git",
        repo_rule = git_repository,
        shallow_since = "1557357026 -0700",
    )

    print("WARNING: Unknown repo type None for repo @eProsima.Fast-DDS")

    print("WARNING: Unknown repo type None for repo @eProsima.foonathan_memory_vendor")

    print("WARNING: Unknown repo type None for repo @eclipse-iceoryx.iceoryx")

    print("WARNING: Unknown repo type None for repo @ros-tooling.libstatistics_collector")

    print("WARNING: Unknown repo type None for repo @ros2.ros2_tracing")
