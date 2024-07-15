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

load(":detail/misc_support.bzl", "get_package_name", "tokenize_message")
load(":providers.bzl", "MsgsInfo", "create_msgs_info_provider")

_DUMMY_PACKAGE_XML = """\
<?xml version="1.0"?>
<?xml-model href="http://download.ros.org/schema/package_format2.xsd" schematypens="http://www.w3.org/2001/XMLSchema"?>
<package format="2">
  <name>{package_name}</name>
  <version>0.0.1</version>
  <description>This is a generated xml</description>
  <maintainer email="generated@apex.ai">Generated</maintainer>
  <license>Apache License 2.0</license>
  <export>
  </export>
</package>
"""

def _convert_to_idl_file(ctx, message_file):
    """Convert a non-idl file to idl one."""

    _, type_name, msg_name, extension = tokenize_message(message_file.path)
    msg_local_path = "{type_name}/{name}.{extension}".format(
        type_name = type_name,
        name = msg_name,
        extension = extension,
    )
    local_idl_file_path = "{name}.{extension}".format(name = msg_name, extension = "idl")

    if extension == "idl":
        out_idl_file = ctx.actions.declare_file(msg_local_path)
        args = ctx.actions.args()
        args.add(message_file)
        args.add(out_idl_file)
        ctx.actions.run(
            inputs = [message_file],
            outputs = [out_idl_file],
            progress_message = "Copying {} to idl".format(message_file.path),
            executable = "/bin/cp",
            arguments = [args],
        )
        return out_idl_file
    elif extension == "srv" or extension == "msg":
        # We symlink the input file to the output folder as the python script for the idl adapter
        # generates the output file in the same folder as the input file. This is the only way I found
        # to make sure the output file is actually populated.
        in_file_symlink = ctx.actions.declare_file(msg_local_path)
        ctx.actions.symlink(
            output = in_file_symlink,
            target_file = message_file,
            progress_message = "Symlink file: {}".format(msg_local_path),
        )

        # We need a dummy xml to trick the idl adapter script into thinking that we are running it from
        # a colcon package for whatever reason. We are not using any dependencies in that script, so
        # this should be safe. An alternative would be to give this function the actual xml file, but
        # for that it would need to be part of the attrs provided to this rule (specified by the user).
        dummy_package_xml = ctx.actions.declare_file("package.xml", sibling = in_file_symlink)
        ctx.actions.write(
            output = dummy_package_xml,
            content = _DUMMY_PACKAGE_XML.format(package_name = get_package_name(ctx)),
        )

        out_idl_file = ctx.actions.declare_file(local_idl_file_path, sibling = in_file_symlink)
        args = ctx.actions.args()
        args.add(in_file_symlink)
        ctx.actions.run(
            inputs = [in_file_symlink, dummy_package_xml],
            outputs = [out_idl_file],
            progress_message = "Convert {} to idl".format(in_file_symlink.path),
            executable = {
                "msg": ctx.executable._msg2idl_idl_adapter,
                "srv": ctx.executable._srv2idl_idl_adapter,
            }[extension],
            arguments = [args],
        )
        return out_idl_file
    else:
        fail(
            "Unable to handle \"" + message_file.path + "\". Message extension is not supported.",
        )

def _rosidl_adapter_impl(ctx):
    idl_files = []
    for src in ctx.files.srcs:
        idl_files.append(_convert_to_idl_file(ctx, src))
    return [
        create_msgs_info_provider(srcs = idl_files, deps = ctx.attr.deps),
        DefaultInfo(
            files = depset(direct = idl_files),
        ),
    ]

rosidl_adapter = rule(
    implementation = _rosidl_adapter_impl,
    provides = [MsgsInfo],
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".idl", ".msg", ".srv"],
            mandatory = True,
        ),
        "deps": attr.label_list(
            providers = [MsgsInfo],
        ),
        "_msg2idl_idl_adapter": attr.label(
            executable = True,
            default = "@ros2.rosidl//rosidl_adapter:msg2idl",
            cfg = "exec",
            doc = "A converter from msg to idl files.",
        ),
        "_srv2idl_idl_adapter": attr.label(
            executable = True,
            default = "@ros2.rosidl//rosidl_adapter:srv2idl",
            cfg = "exec",
            doc = "A converter from srv to idl files.",
        ),
    },
)
