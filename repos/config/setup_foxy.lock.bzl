#
# DO NOT EDIT THIS FILE MANUALLY!
#
# To update, call `bazel run @rules_ros//repos/config:repos_lock.update` with the right distro set in the WORKSPACE
#

load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
load("@rules_ros//repos/config/detail:git_repository.bzl", _git_repository = "git_repository")
load("@rules_ros//repos/config/detail:http_archive.bzl", "http_archive")
load("@rules_ros//repos/config/detail:new_local_repository.bzl", _new_local_repository = "new_local_repository")

def setup():
    pass


    _maybe(
        name = "ament.ament_index",
        branch = "1.1.0",
        build_files = {
            "@rules_ros//repos:ament.ament_index/ament_index_cpp.BUILD": "ament_index_cpp/BUILD.bazel",
            "@rules_ros//repos:ament.ament_index/ament_index_python.BUILD": "ament_index_python/BUILD.bazel",
        },
        commit = "07492c3ada0f835464ef55178080f3df93c22292",
        remote = "https://github.com/ament/ament_index.git",
        repo_rule = _git_repository,
        shallow_since = "1625088023 -0700",
    )


    _maybe(
        name = "eProsima.Fast-CDR",
        branch = "v1.0.13",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "174f6ff1d3a227c5c900a4587ee32fa888267f5e",
        remote = "https://github.com/eProsima/Fast-CDR.git",
        repo_rule = _git_repository,
        shallow_since = "1585310200 +0100",
    )


    _maybe(
        name = "eProsima.Fast-DDS",
        branch = "v2.1.3",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "680cb71c7f3a9fb4b7e348d7d68ee2dbf4dd6d8d",
        remote = "https://github.com/eProsima/Fast-DDS.git",
        repo_rule = _git_repository,
        shallow_since = "1674805970 +0100",
    )


    _maybe(
        name = "eProsima.foonathan_memory_vendor",
        branch = "v1.2.0",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "da062db05975d24a4b53de5a4122b47f6824997f",
        remote = "https://github.com/eProsima/foonathan_memory_vendor.git",
        repo_rule = _git_repository,
        shallow_since = "1637848987 +0100",
    )


    _maybe(
        name = "eclipse-cyclonedds.cyclonedds",
        branch = "0.7.0",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "c261053186c455abc63ca5ac7d56c0808a59c364",
        remote = "https://github.com/eclipse-cyclonedds/cyclonedds.git",
        repo_rule = _git_repository,
        shallow_since = "1596471565 +0200",
    )


    _maybe(
        name = "ros-tooling.libstatistics_collector",
        branch = "1.0.2",
        build_files = {
            "@rules_ros//repos:ros-tooling.libstatistics_collector/root.BUILD": "BUILD.bazel",
        },
        commit = "28e3c4634dc106b1e5209a776e9a56325f16c84a",
        remote = "https://github.com/ros-tooling/libstatistics_collector.git",
        repo_rule = _git_repository,
        shallow_since = "1678980793 -0400",
    )


    _maybe(
        name = "ros2.common_interfaces",
        branch = "2.0.5",
        build_files = {
            "@rules_ros//repos:ros2.common_interfaces/std_msgs.BUILD": "std_msgs/BUILD.bazel",
        },
        commit = "6356bc82f3a034f5d2c61c6760df0007a6cadfb0",
        remote = "https://github.com/ros2/common_interfaces.git",
        repo_rule = _git_repository,
        shallow_since = "1640218063 +0000",
    )


    _maybe(
        name = "ros2.rcl",
        branch = "1.1.14",
        build_files = {
            "@rules_ros//repos:ros2.rcl/rcl.BUILD": "rcl/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl/rcl_yaml_param_parser.BUILD": "rcl_yaml_param_parser/BUILD.bazel",
        },
        commit = "287ccd9ed06ff5bdded4dfb1130920d592a71bb7",
        remote = "https://github.com/ros2/rcl.git",
        repo_rule = _git_repository,
        shallow_since = "1658776609 -0700",
    )


    _maybe(
        name = "ros2.rcl_interfaces",
        branch = "1.0.0",
        build_files = {
            "@rules_ros//repos:ros2.rcl_interfaces/rcl_interfaces.BUILD": "rcl_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/rosgraph_msgs.BUILD": "rosgraph_msgs/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/builtin_interfaces.BUILD": "builtin_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/statistics_msgs.BUILD": "statistics_msgs/BUILD.bazel",
        },
        commit = "48cb91129051a494f3b4b097dccd6c921bb50552",
        remote = "https://github.com/ros2/rcl_interfaces.git",
        repo_rule = _git_repository,
        shallow_since = "1590522301 +0000",
    )


    _maybe(
        name = "ros2.rcl_logging",
        branch = "1.1.0",
        build_files = {
            "@rules_ros//repos:ros2.rcl_logging/rcl_logging_interface.BUILD": "rcl_logging_interface/BUILD.bazel",
        },
        commit = "d22a6630f039bee97c6667394def926a5426a673",
        remote = "https://github.com/ros2/rcl_logging.git",
        repo_rule = _git_repository,
        shallow_since = "1618435530 -0700",
    )


    _maybe(
        name = "ros2.rclcpp",
        branch = "2.4.3",
        build_files = {
            "@rules_ros//repos:ros2.rclcpp/build_interfaces.py": "rclcpp/build_interfaces.py",
            "@rules_ros//repos:ros2.rclcpp/rclcpp.BUILD": "rclcpp/BUILD.bazel",
        },
        commit = "b0c25d5f22237d42e2cedad05dbb2e5cc31a3cf4",
        remote = "https://github.com/ros2/rclcpp.git",
        repo_rule = _git_repository,
        shallow_since = "1685154213 +0000",
    )


    _maybe(
        name = "ros2.rcpputils",
        branch = "1.3.2",
        build_files = {
            "@rules_ros//repos:ros2.rcpputils/rcpputils.BUILD": "BUILD.bazel",
        },
        commit = "f4ce24de0b9b6b2c0c3807d6ce43418d4e1db331",
        remote = "https://github.com/ros2/rcpputils.git",
        repo_rule = _git_repository,
        shallow_since = "1630457027 -0700",
    )


    _maybe(
        name = "ros2.rcutils",
        branch = "1.1.5",
        build_files = {
            "@rules_ros//repos:ros2.rcutils/root.BUILD": "BUILD.bazel",
            "@rules_ros//repos:ros2.rcutils/build_logging_macros.py": "build_logging_macros.py",
        },
        commit = "7cc5a47ee5d85d605d2291c1b04ac570a4c0faf6",
        remote = "https://github.com/ros2/rcutils.git",
        repo_rule = _git_repository,
        shallow_since = "1678961835 +0000",
    )


    _maybe(
        name = "ros2.rmw",
        branch = "1.0.4",
        build_files = {
            "@rules_ros//repos:ros2.rmw/rmw.BUILD": "rmw/BUILD.bazel",
        },
        commit = "7fa45cb0d86fef00488e707b9ef37914d7ff0369",
        remote = "https://github.com/ros2/rmw.git",
        repo_rule = _git_repository,
        shallow_since = "1678961864 +0000",
    )


    _maybe(
        name = "ros2.ros2_tracing",
        branch = "1.0.5",
        build_files = {
            "@rules_ros//repos:ros2.ros2_tracing/tracetools.BUILD": "tracetools/BUILD.bazel",
        },
        commit = "f10fb2c13775fa0220833c5fa4ff82660640362a",
        remote = "https://github.com/ros2/ros2_tracing.git",
        repo_rule = _git_repository,
        shallow_since = "1608651744 -0500",
    )


    _maybe(
        name = "ros2.ros2cli",
        branch = "0.9.13",
        build_files = {
            "@rules_ros//repos:ros2.ros2cli/ros2cli.BUILD": "ros2cli/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2pkg.BUILD": "ros2pkg/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2run.BUILD": "ros2run/BUILD.bazel",
        },
        commit = "26715cbb0948258d6f04b94c909d035c5130456a",
        remote = "https://github.com/ros2/ros2cli.git",
        repo_rule = _git_repository,
        shallow_since = "1678961891 +0000",
    )


    _maybe(
        name = "ros2.rosidl",
        branch = "1.3.1",
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
        commit = "62bc7072d9078cfd7c63ebb1d12ca6e9732491b4",
        remote = "https://github.com/ros2/rosidl.git",
        repo_rule = _git_repository,
        shallow_since = "1685154334 +0000",
    )


    _maybe(
        name = "ros2.rosidl_dds",
        branch = "0.7.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_dds/rosidl_generator_dds_idl.BUILD": "rosidl_generator_dds_idl/BUILD.bazel",
        },
        commit = "e88b1d0e62a2dca0788142cf1fb266a3a3c3d7dc",
        remote = "https://github.com/ros2/rosidl_dds.git",
        repo_rule = _git_repository,
        shallow_since = "1557357026 -0500",
    )


    _maybe(
        name = "ros2.rosidl_typesupport",
        branch = "1.0.3",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_typesupport/rosidl_typesupport_c.BUILD": "rosidl_typesupport_c/BUILD.bazel",
        },
        commit = "08bec09e39f68a29ca15d8177f084118a47eaa92",
        remote = "https://github.com/ros2/rosidl_typesupport.git",
        repo_rule = _git_repository,
        shallow_since = "1685154344 +0000",
    )


    print("WARNING: Unknown repo type None for repo @eclipse-iceoryx.iceoryx")
