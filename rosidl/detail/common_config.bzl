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

load(":detail/misc_support.bzl", "get_package_name")

def _create_common_config_internal(ctx, *, srcs, output_directory, split_position, output_file_create_func, skip_first_filepath_element = False, append_extra_package_name = False):
    # Step 0: Config
    package_name = get_package_name(ctx)

    # Step 1: Prepare output list
    _outputs = []
    _idl_tuples = []
    _subdir = None
    for src in srcs:
        _src_split = src.path.split("/")
        _subdir = "/".join(_src_split[:-split_position])
        _filepath = "/".join(_src_split[-split_position + (1 if skip_first_filepath_element else 0):-1])
        _filename = _src_split[-1]
        _idl_tuples.append(_subdir + ":" + _filepath + "/" + _filename)
        for output_file_name in output_file_create_func(_filename):
            _output_temp = output_directory + "/" if output_directory else ""
            _outputs.append(ctx.actions.declare_file(_output_temp + _filepath + "/" + output_file_name))

    # Step 2: Fixed set of dirnames for msg, srv
    _dirnames = ["msg", "srv"]

    # Step 3: Check if any output available ... no output is an error!
    if not _subdir:
        fail("Nothing to generate.")

    # Return result
    return struct(
        package_name = package_name,
        output_dir = _subdir + "/" + (package_name + "/" if append_extra_package_name else "") + output_directory if output_directory else _subdir,
        output_dir_relative = output_directory,
        output_dir_subdir = _subdir,
        outputs = _outputs,
        idl_tuples = _idl_tuples,
        dirnames = _dirnames,
    )

def create_common_config(ctx, *, srcs, output_file_create_func):
    return _create_common_config_internal(
        ctx,
        srcs = srcs,
        output_directory = get_package_name(ctx),
        split_position = 2,
        output_file_create_func = output_file_create_func,
    )

def create_common_config_for_dds_idl_generator(ctx, *, srcs, output_file_create_func):
    return _create_common_config_internal(
        ctx,
        srcs = srcs,
        output_directory = None,
        split_position = 2,
        output_file_create_func = output_file_create_func,
    )

def create_common_config_for_apex_middleware_typefiles_generator(ctx, *, output_file_create_func):
    return _create_common_config_internal(
        ctx,
        srcs = ctx.files.srcs,
        output_directory = get_package_name(ctx),
        split_position = 4,
        output_file_create_func = output_file_create_func,
        skip_first_filepath_element = True,
        append_extra_package_name = True,
    )
