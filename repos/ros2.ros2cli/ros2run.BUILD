# Copyright 2024 Apex.AI, Inc.
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
    name = "ros2run_py",
    srcs = glob(["ros2run/**/*.py"]),
)

py_wheel(
    name = "ros2run_whl",
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
    # description_file = "README.md",
    distribution = "ros2run",
    #tests_require=['pytest'],
    entry_points = {
        "ros2cli.command": [
            "run = ros2run.command.run:RunCommand",
        ],
    },
    license = "Apache License, Version 2.0",
    strip_path_prefixes = ["ros2run"],
    version = "0.8.6",
    visibility = ["//visibility:public"],
    deps = [":ros2run_py"],
)

ros_pkg(
    name = "ros2run",
    description = "The run command for ROS 2 command line tools.",
    license = "Apex.AI License",
    maintainer_email = "dthomas@osrfoundation.org",
    maintainer_name = "Dirk Thomas",
    pkg_name = "ros2run",
    py_packages = ["ros2run_whl"],
    version = "0.8.6",
    visibility = ["//visibility:public"],
)
