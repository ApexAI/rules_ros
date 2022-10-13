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

MsgsInfo = provider(
    doc = """
    Provider for a set of idl files containing message definitions.
    Fields:
        srcs: list of files (*.idl, *.srv)
        deps: depset of targets containing a MsgsInfo provider.
    """,
    fields = [
        "srcs",
        "deps",
    ],
)

def create_msgs_info_provider(*, srcs = None, deps = None):
    """
    Create a `MsgsInfo` provider object.

    Arguments:
        srcs: idl files containing message and service definitions.
        deps: list of dependencies that contain `MsgsInfo` providers.
               Dependencies without a `MsgsInfo` provider will be ignored.
    """
    srcs = [] if srcs == None else srcs
    deps = [] if deps == None else deps

    deps = depset(
        direct = [dep for dep in deps if MsgsInfo in dep],
        transitive = [dep[MsgsInfo].deps for dep in deps if MsgsInfo in dep],
    )
    return MsgsInfo(srcs = srcs, deps = deps)

def get_files_from_deps(msgs_info):
    msgs_info_list = [target[MsgsInfo] for target in msgs_info.deps.to_list()]
    files = []
    for msgs_info in msgs_info_list:
        files.extend(msgs_info.srcs)
    return files

def get_all_files(msgs_info):
    files = get_files_from_deps(msgs_info)
    files.extend(msgs_info.srcs)
    return files
