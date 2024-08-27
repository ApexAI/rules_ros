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
        branch = "0.7.2",
        build_files = {
            "@rules_ros//repos:ament.ament_index/ament_index_cpp.BUILD": "ament_index_cpp/BUILD.bazel",
            "@rules_ros//repos:ament.ament_index/ament_index_python.BUILD": "ament_index_python/BUILD.bazel",
        },
        commit = "9d42ba13d7694ad8da5b1622e433e691996c4502",
        remote = "https://github.com/ament/ament_index.git",
        repo_rule = _git_repository,
        shallow_since = "1571244457 -0700",
    )


    _maybe(
        name = "eProsima.Fast-CDR",
        branch = "v1.0.11",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "cc27c2490b694e97ca1bbcc169172fd63209bb90",
        remote = "https://github.com/eProsima/Fast-CDR.git",
        repo_rule = _git_repository,
        shallow_since = "1566903518 +0200",
    )


    _maybe(
        name = "eProsima.Fast-DDS",
        branch = "v1.9.3",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "b5ae9e9c9ea7ce49c64c0ef3f6c96a3dc563b16f",
        remote = "https://github.com/eProsima/Fast-DDS.git",
        repo_rule = _git_repository,
        shallow_since = "1573725955 +0100",
    )


    _maybe(
        name = "eProsima.foonathan_memory_vendor",
        branch = "v0.3.0",
        build_files = {
            "@rules_ros//repos:default.BUILD": "BUILD.bazel",
        },
        commit = "017ff0bdfd2c93930bf525a01f8663a032337a14",
        remote = "https://github.com/eProsima/foonathan_memory_vendor.git",
        repo_rule = _git_repository,
        shallow_since = "1569302929 +0200",
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
        name = "ros2.common_interfaces",
        branch = "0.8.1",
        build_files = {
            "@rules_ros//repos:ros2.common_interfaces/std_msgs.BUILD": "std_msgs/BUILD.bazel",
        },
        commit = "81663c07b93889c3d0afda9b99cd5f1c7c98c1f2",
        remote = "https://github.com/ros2/common_interfaces.git",
        repo_rule = _git_repository,
        shallow_since = "1571867898 -0700",
    )


    _maybe(
        name = "ros2.rcl",
        branch = "0.8.5",
        build_files = {
            "@rules_ros//repos:ros2.rcl/rcl.BUILD": "rcl/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl/rcl_yaml_param_parser.BUILD": "rcl_yaml_param_parser/BUILD.bazel",
        },
        commit = "f5c01e4e2eb5d8f7fb16321f81815cd4b6b200bd",
        remote = "https://github.com/ros2/rcl.git",
        repo_rule = _git_repository,
        shallow_since = "1607116198 -0600",
    )


    _maybe(
        name = "ros2.rcl_interfaces",
        branch = "0.8.0",
        build_files = {
            "@rules_ros//repos:ros2.rcl_interfaces/rcl_interfaces.BUILD": "rcl_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/rosgraph_msgs.BUILD": "rosgraph_msgs/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/builtin_interfaces.BUILD": "builtin_interfaces/BUILD.bazel",
            "@rules_ros//repos:ros2.rcl_interfaces/statistics_msgs.BUILD": "statistics_msgs/BUILD.bazel",
        },
        commit = "93cedce2dacd25fa4f2969d022ccbe3f2903e3fe",
        remote = "https://github.com/ros2/rcl_interfaces.git",
        repo_rule = _git_repository,
        shallow_since = "1569518728 -0500",
    )


    _maybe(
        name = "ros2.rcl_logging",
        branch = "0.3.3",
        build_files = {
            "@rules_ros//repos:ros2.rcl_logging/rcl_logging_interface.BUILD": "rcl_logging_interface/BUILD.bazel",
        },
        commit = "3955fc4fc37e46dc397c52cebd3e40732db1157d",
        remote = "https://github.com/ros2/rcl_logging.git",
        repo_rule = _git_repository,
        shallow_since = "1571871211 +0000",
    )


    _maybe(
        name = "ros2.rclcpp",
        branch = "0.8.5",
        build_files = {
            "@rules_ros//repos:ros2.rclcpp/build_interfaces.py": "rclcpp/build_interfaces.py",
            "@rules_ros//repos:ros2.rclcpp/rclcpp.BUILD": "rclcpp/BUILD.bazel",
        },
        commit = "82202ae71f14fed3a487da90d8f4f74c07c7d1f7",
        remote = "https://github.com/ros2/rclcpp.git",
        repo_rule = _git_repository,
        shallow_since = "1607116009 -0600",
    )


    _maybe(
        name = "ros2.rcpputils",
        branch = "0.2.1",
        build_files = {
            "@rules_ros//repos:ros2.rcpputils/rcpputils.BUILD": "BUILD.bazel",
        },
        commit = "33e2edb1dafd9dc1952e7f219c9ceee58905b831",
        remote = "https://github.com/ros2/rcpputils.git",
        repo_rule = _git_repository,
        shallow_since = "1573612278 -0800",
    )


    _maybe(
        name = "ros2.rcutils",
        branch = "0.8.5",
        build_files = {
            "@rules_ros//repos:ros2.rcutils/root.BUILD": "BUILD.bazel",
            "@rules_ros//repos:ros2.rcutils/build_logging_macros.py": "build_logging_macros.py",
        },
        commit = "ef201364d5af13f74a9c368f271c762326d838be",
        remote = "https://github.com/ros2/rcutils.git",
        repo_rule = _git_repository,
        shallow_since = "1607117730 -0600",
    )


    _maybe(
        name = "ros2.rmw",
        branch = "0.8.1",
        build_files = {
            "@rules_ros//repos:ros2.rmw/rmw.BUILD": "rmw/BUILD.bazel",
        },
        commit = "813b94ddd5650444b312304ad156f3b5d9f05e39",
        remote = "https://github.com/ros2/rmw.git",
        repo_rule = _git_repository,
        shallow_since = "1571879357 -0700",
    )


    _maybe(
        name = "ros2.ros2cli",
        branch = "0.8.8",
        build_files = {
            "@rules_ros//repos:ros2.ros2cli/ros2cli.BUILD": "ros2cli/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2pkg.BUILD": "ros2pkg/BUILD.bazel",
            "@rules_ros//repos:ros2.ros2cli/ros2run.BUILD": "ros2run/BUILD.bazel",
        },
        commit = "5d5b855369085d02631bc5bdd6ffb7fae680eb5b",
        remote = "https://github.com/ros2/ros2cli.git",
        repo_rule = _git_repository,
        shallow_since = "1607117614 -0600",
    )


    _maybe(
        name = "ros2.rosidl",
        branch = "0.8.3",
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
        commit = "5f79cdcb7830999b527c2370b4397a3cc587374a",
        remote = "https://github.com/ros2/rosidl.git",
        repo_rule = _git_repository,
        shallow_since = "1607117948 -0600",
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
        branch = "0.8.1",
        build_files = {
            "@rules_ros//repos:ros2.rosidl_typesupport/rosidl_typesupport_c.BUILD": "rosidl_typesupport_c/BUILD.bazel",
        },
        commit = "b51759ea94bfdc58afc8831d4c847c5891d14bc3",
        remote = "https://github.com/ros2/rosidl_typesupport.git",
        repo_rule = _git_repository,
        shallow_since = "1607118075 -0600",
    )


    print("WARNING: Unknown repo type None for repo @eclipse-iceoryx.iceoryx")


    print("WARNING: Unknown repo type None for repo @ros-tooling.libstatistics_collector")


    print("WARNING: Unknown repo type None for repo @ros2.ros2_tracing")

