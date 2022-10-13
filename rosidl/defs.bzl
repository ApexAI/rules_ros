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

load(":detail/rosidl_adapter.bzl", _rosidl_adapter = "rosidl_adapter")
load(":detail/rosidl_generator_c.bzl", _cc_rosidl_generator_c_library = "cc_rosidl_generator_c_library")
load(":detail/rosidl_generator_cpp.bzl", _cc_rosidl_generator_cpp_library = "cc_rosidl_generator_cpp_library")
load(":detail/rosidl_typesupport_c.bzl", _cc_rosidl_typesupport_c_library = "cc_rosidl_typesupport_c_library")
load(":detail/cc_library_with_msgs_provider.bzl", _msgs_library_with_cc ="msgs_library_with_cc")

raw_msgs_library = _rosidl_adapter

def msgs_library(
        *,
        name,
        srcs = [],
        deps = [],
        visibility = None):
    """ Create a library for msg/srv/idl files with all default bindings (currently C++)

    Provides:
        This rule provides a `MsgsInfo` provider to be used as a dependency for other msgs_library.
        It also provides a `CcInfo` provider to be used as a dependency for C/C++ library with the cc toolchain.

        This macro provides an auxilary target `{name}__raw__` which only contains the `MsgsInfo`
        provider without any bindings.

    Args:
        name: [String] The target name
        srcs: [List of Labels] Idl files (of all kinds msg, srv, idl)
        deps: [List of Labels] Dependencies to `cc_library` or other `msgs_library`
        visibility: Visability label
    """

    # Convert: *.msg, *.srv -> *.idl (ROS), Copy: *.idl -> *.idl (ROS)
    name_raw = "{}_raw".format(name)
    _rosidl_adapter(
        name = name_raw,
        srcs = srcs,
        deps = deps,
        visibility = visibility,
    )

    # Collect generated cc_libraries
    cc_libs = []

    # Library with rosidl_generator_c
    name_rosidl_generator_c = "{}__rosidl_generator_c".format(name)
    cc_libs.append(":" + name_rosidl_generator_c)
    _cc_rosidl_generator_c_library(
        name = name_rosidl_generator_c,
        srcs = [":" + name_raw],
        deps = [
            "@ros2.rosidl//rosidl_runtime_c",
        ] + deps,
    )

    # Library with rosidl_generator_cpp
    name_rosidl_generator_cpp = "{}__rosidl_generator_cpp".format(name)
    cc_libs.append(":" + name_rosidl_generator_cpp)
    _cc_rosidl_generator_cpp_library(
        name = name_rosidl_generator_cpp,
        srcs = [":" + name_raw],
        deps = [
            "@ros2.rosidl//rosidl_runtime_cpp",
        ] + deps,
        linkstatic = True,  # No object files
    )

    # Library with rosidl_typesupport_c
    name_rosidl_typesupport_c = "{}__rosidl_typesupport_c".format(name)
    cc_libs.append(":" + name_rosidl_typesupport_c)
    _cc_rosidl_typesupport_c_library(
        name = name_rosidl_typesupport_c,
        srcs = [":" + name_raw],
        typesupports = ["rmw_cyclonedds_cpp"],
        deps = [
            ":" + name_rosidl_generator_c,
            "@ros2.rosidl_typesupport//rosidl_typesupport_c",
        ] + deps,
    )


    _msgs_library_with_cc(
        name = name,
        deps = cc_libs + deps,
        msgs = ":" + name_raw,
        visibility = visibility,
    )



