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
load("@rules_python//python:python.bzl", "py_test")
load("@rules_ros//pkg:defs.bzl", "ros_pkg")
load("@python_deps//:requirements.bzl", "requirement")

py_library(
    name = "ament_index_python_py",
    srcs = glob(["ament_index_python/**/*.py"]),
)

py_test(
    name = "ament_index_python_py_test",
    srcs = ["test/test_ament_index_python.py"],
    imports = ["."],
    main = "test/test_ament_index_python.py",
    deps = [
        ":ament_index_python_py",
        requirement("attrs"),
        requirement("pluggy"),
        requirement("pytest"),
    ],
)

py_wheel(
    name = "ament_index_python_whl",
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
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Programming Language :: Python",
        "Topic :: Software Development",
    ],
    #description_file = "README.md",
    distribution = "ament_index_python",
    #tests_require=['pytest'],
    license = "Apache License, Version 2.0",
    strip_path_prefixes = ["ament_index_python"],
    version = "0.8.6",
    deps = [":ament_index_python_py"],
    entry_points = {
        "console_scripts": [
            "ament_index = ament_index_python.cli:main",
        ],
    },
)

ros_pkg(
    name = "ament_index_python",
    description = "Python API to access the ament resource index.",
    license = "Apex.AI License",
    maintainer_name = "Dirk Thomas",
    maintainer_email = "dthomas@osrfoundation.org",
    pkg_name = "ament_index_python",
    py_packages = ["ament_index_python_whl"],
    version = "0.7.2",
    visibility = ["//visibility:public"],
)
