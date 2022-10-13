# Copyright 2022 Apex.AI, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@rules_python//python:packaging.bzl", "py_wheel")
load("@rules_ros//pkg:defs.bzl", "ros_pkg")

py_library(
    name = "ros2cli_py",
    srcs = glob(["ros2cli/**/*.py"]),
)

py_wheel(
    name = "ros2cli_whl",
    # packages=find_packages(exclude=['test']),
    # data_files=[
    #     ('share/' + package_name, ['package.xml']),
    #     ('share/ament_index/resource_index/packages',
    #         ['resource/' + package_name]),
    # ],
    # install_requires=['ros2cli'],
    # zip_safe=True,
    author = "Dirk Thomas",
    author_email = "dthomas@osrfoundation.org",
    # maintainer='Dirk Thomas',
    # maintainer_email='dthomas@osrfoundation.org',
    # url='https://github.com/ros2/ros2cli/tree/master/ros2run',
    # download_url='https://github.com/ros2/ros2cli/releases',
    # keywords=[],
    classifiers = [
        "Environment :: Console",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Programming Language :: Python",
    ],
    #description_file = "README.md",
    distribution = "ros2cli",
    #tests_require=['pytest'],
    entry_points = {
        "ros2cli.command": [
            "daemon = ros2cli.command.daemon:DaemonCommand",
            "extension_points = ros2cli.command.extension_points:ExtensionPointsCommand",
            "extensions = ros2cli.command.extensions:ExtensionsCommand",
        ],
        "ros2cli.extension_point": [
            "ros2cli.command = ros2cli.command:CommandExtension",
            "ros2cli.daemon.verb = ros2cli.verb.daemon:VerbExtension",
        ],
        "ros2cli.daemon.verb": [
            "start = ros2cli.verb.daemon.start:StartVerb",
            "status = ros2cli.verb.daemon.status:StatusVerb",
            "stop = ros2cli.verb.daemon.stop:StopVerb",
        ],
        "console_scripts": [
            "ros2 = ros2cli.cli:main",
            "_ros2_daemon = ros2cli.daemon:main",
        ],
    },
    license = "Apache License, Version 2.0",
    strip_path_prefixes = ["ros2cli"],
    version = "0.8.6",
    deps = [":ros2cli_py"],
)

ros_pkg(
    name = "ros2cli",
    description = "Framework for ROS 2 command line tools.",
    license = "Apex.AI License",
    maintainer_email = "dthomas@osrfoundation.org",
    maintainer_name = "Dirk Thomas",
    pkg_name = "ros2cli",
    py_packages = ["ros2cli_whl"],
    deps = [
        "//ros2pkg",
        "//ros2run",
        "@ament.ament_index//ament_index_python",
    ],
    version = "0.8.6",
    visibility = ["//visibility:public"],
)
