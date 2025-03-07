#
# DO NOT EDIT THIS FILE MANUALLY!
#
# To update, call `bazel run @rules_ros//repos/config:repos_lock.update` with the right distro set in the WORKSPACE
#
# SHA256 of external/ros2/ros2.repos: 208a8f0618b3f5a90b7301ca07a2f3b1f918d3531cd3acab0c9ca62ff8a5d19d

load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
load("@rules_ros//repos/config/detail:git_repository.bzl", "git_repository")
load("@rules_ros//repos/config/detail:http_archive.bzl", "http_archive")
load("@rules_ros//repos/config/detail:new_local_repository.bzl", "new_local_repository")

def setup():
    pass

    _maybe(
        name = "ament.ament_index",
        branch = "1.5.2",
        build_files = {
            "@rules_ros//repos:ament.ament_index/ament_index_cpp.BUILD": "ament_index_cpp/BUILD.bazel",
            "@rules_ros//repos:ament.ament_index/ament_index_python.BUILD": "ament_index_python/BUILD.bazel",
        },
        commit = "ba818db036e82d5f752d17e3e6fe6e3efd583bfb",
        remote = "https://github.com/ament/ament_index.git",
        repo_rule = git_repository,
        shallow_since = "1676390119 +0000",
    )

    _maybe(
        name = "eProsima.Fast-CDR",
        branch = "v1.0.27",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "5d782877435b569e0ed38541f362e212c9123dd4",
        remote = "https://github.com/eProsima/Fast-CDR.git",
        repo_rule = git_repository,
        shallow_since = "1679466588 +0100",
    )

    _maybe(
        name = "eProsima.Fast-DDS",
        branch = "2.10.2",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "2be7879185bfa2b67d5a9777ddee0a7e637776f3",
        remote = "https://github.com/eProsima/Fast-DDS.git",
        repo_rule = git_repository,
        shallow_since = "1692360029 +0200",
    )

    _maybe(
        name = "eProsima.foonathan_memory_vendor",
        branch = "v1.3.0",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "8db2afc097db4cebe414ae27cdb3af1480ae46e7",
        remote = "https://github.com/eProsima/foonathan_memory_vendor.git",
        repo_rule = git_repository,
        shallow_since = "1676364830 +0100",
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
        branch = "1.5.1",
        build_files = {
            "@rules_ros//repos:ros-tooling.libstatistics_collector/root.BUILD": "BUILD.bazel",
        },
        commit = "00b9371c15fdc9b3f42faee3cb718214b787eb13",
        remote = "https://github.com/ros-tooling/libstatistics_collector.git",
        repo_rule = git_repository,
        shallow_since = "1681306122 +0000",
    )

    _maybe(
        name = "ros2.common_interfaces",
        branch = "5.0.0",
        build_files = {
            "@rules_ros//repos:ros2.common_interfaces/std_msgs.BUILD": "std_msgs/BUILD.bazel",
        },
        commit = "86801a504b97f25a3b6e1c36e42a445500c98f79",
        remote = "https://github.com/ros2/common_interfaces.git",
        repo_rule = git_repository,
        shallow_since = "1681224748 +0000",
    )

    _maybe(
        name = "ros2.rcl",
        branch = "6.0.3",
        build_files = {
            "@rules_ros//repos:ros2.rcl/rcl.BUILD": "rcl/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl/rcl_yaml_param_parser.BUILD": "rcl_yaml_param_parser/BUILD.bazel",
        },
        commit = "71ecc97db05490981f3e37ced27c66f8905879e8",
        remote = "https://github.com/ros2/rcl.git",
        repo_rule = git_repository,
        shallow_since = "1694151357 +0800",
    )

    _maybe(
        name = "ros2.rcl_interfaces",
        branch = "1.6.0",
        build_files = {
            "@rules_ros//repos:ros2.rcl_interfaces/rcl_interfaces.BUILD": "rcl_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/rosgraph_msgs.BUILD": "rosgraph_msgs/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/builtin_interfaces.BUILD": "builtin_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/statistics_msgs.BUILD": "statistics_msgs/BUILD.bazel",
        },
        commit = "6d28b16a6f74485af03a2c4f043dd568e576c25e",
        remote = "https://github.com/ros2/rcl_interfaces.git",
        repo_rule = git_repository,
        shallow_since = "1681820432 +0000",
    )

    _maybe(
        name = "ros2.rcl_logging",
        branch = "2.5.1",
        build_files = {
            "@rules_ros//repos:ros2.rcl_logging/rcl_logging_interface.BUILD": "rcl_logging_interface/BUILD.bazel",
        },
        commit = "2bc49ab7ff557a45d4fa152e2f400e9ad2bb6a68",
        remote = "https://github.com/ros2/rcl_logging.git",
        repo_rule = git_repository,
        shallow_since = "1681252296 -0700",
    )

    _maybe(
        name = "ros2.rclcpp",
        branch = "21.0.3",
        build_files = {
            "@rules_ros//repos:ros2.rclcpp/build_interfaces.py": "rclcpp/build_interfaces.py",
            "@rules_ros//repos:ros2.rclcpp/rclcpp.BUILD": "rclcpp/BUILD.bazel",
        },
        commit = "45df3555d2daee48332f7dad1e6dabc7e4a7fd60",
        remote = "https://github.com/ros2/rclcpp.git",
        repo_rule = git_repository,
        shallow_since = "1694151852 +0800",
    )

    _maybe(
        name = "ros2.rcpputils",
        branch = "2.6.1",
        build_files = {
            "@rules_ros//repos:ros2.rcpputils/rcpputils.BUILD": "BUILD.bazel",
        },
        commit = "39b20134e571ba74baa7c77750eab586da90b7a5",
        remote = "https://github.com/ros2/rcpputils.git",
        repo_rule = git_repository,
        shallow_since = "1676322161 +0000",
    )

    _maybe(
        name = "ros2.rcutils",
        branch = "6.2.1",
        build_files = {
            "@rules_ros//repos:ros2.rcutils/root.BUILD": "BUILD.bazel",
            "@rules_ros//repos:ros2.rcutils/build_logging_macros.py": "build_logging_macros.py",
        },
        commit = "04aa9804feb46403f0058f4b089134a6985e19d3",
        remote = "https://github.com/ros2/rcutils.git",
        repo_rule = git_repository,
        shallow_since = "1681305660 +0000",
    )

    _maybe(
        name = "ros2.rmw",
        branch = "7.1.0",
        build_files = {
            "@rules_ros//repos:ros2.rmw/rmw.BUILD": "rmw/BUILD.bazel",
        },
        commit = "17e3a94e447cd043dc20aec7dd620b5eb26241c6",
        remote = "https://github.com/ros2/rmw.git",
        repo_rule = git_repository,
        shallow_since = "1681312425 +0000",
    )

    _maybe(
        name = "ros2.ros2_tracing",
        branch = "6.3.1",
        build_files = {
            "@rules_ros//repos:ros2.ros2_tracing/tracetools.BUILD": "tracetools/BUILD.bazel",
        },
        commit = "fb240709fda0e0cc6c08f12ae8052d3a32221d29",
        remote = "https://github.com/ros2/ros2_tracing.git",
        repo_rule = git_repository,
        shallow_since = "1683805768 +0800",
    )

    _maybe(
        name = "ros2.ros2cli",
        branch = "0.25.3",
        build_files = {
            "@rules_ros//repos:ros2.ros2cli/ros2cli.BUILD": "ros2cli/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2pkg.BUILD": "ros2pkg/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2run.BUILD": "ros2run/BUILD.bazel",
        },
        commit = "4d92fa27ca0d7796c1f792864fd98dd3b7437f8f",
        remote = "https://github.com/ros2/ros2cli.git",
        repo_rule = git_repository,
        shallow_since = "1694153559 +0800",
    )

    _maybe(
        name = "ros2.rosidl",
        branch = "4.0.1",
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
        commit = "995917e9ce14d17821c04bf28d5a092111537842",
        remote = "https://github.com/ros2/rosidl.git",
        repo_rule = git_repository,
        shallow_since = "1689270954 +0800",
    )

    _maybe(
        name = "ros2.rosidl_dds",
        branch = "0.10.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_dds/rosidl_generator_dds_idl.BUILD": "rosidl_generator_dds_idl/BUILD.bazel",
        },
        commit = "f074b295c316e9bbb9845344cc6ab882339e9305",
        remote = "https://github.com/ros2/rosidl_dds.git",
        repo_rule = git_repository,
        shallow_since = "1676323645 +0000",
    )

    _maybe(
        name = "ros2.rosidl_typesupport",
        branch = "3.0.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_typesupport/rosidl_typesupport_c.BUILD": "rosidl_typesupport_c/BUILD.bazel",
        },
        commit = "7cadef85a4f4e633d8598210ce99d47a3dde52a9",
        remote = "https://github.com/ros2/rosidl_typesupport.git",
        repo_rule = git_repository,
        shallow_since = "1689271321 +0800",
    )
