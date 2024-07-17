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

_POSSIBLE_TYPES = ["msg", "srv", "idl"]

def get_package_name(ctx):
    """Get the name of the package form its rule context label."""
    return ctx.label.package.split("/")[-1]

def tokenize_message(msg_path):
    """
    Split a message into its folder path, type, message name and extension.

    Example: "blah/msg/String.idl" -> ["blah", "msg", "String", "idl"]

    :param      msg_path:  Path to a message

    :returns:   A tuple of path, name, extension: "blah/msg/String.idl" -> ["blah", "String", "idl"]
    """
    for type_name in _POSSIBLE_TYPES:
        type_with_slashes = "/{}/".format(type_name)
        if type_with_slashes in msg_path:
            local_folder_path, msg_with_extension = msg_path.split(type_with_slashes)
            msg_name, extension = msg_with_extension.split(".")
            return local_folder_path, type_name, msg_name, extension
    fail("Message source {} must have one of {} prefixes.".format(msg_path, _POSSIBLE_TYPES))

def to_snake_case(name):
    """ Translate a name to snake case.
        Will translate
        'AbcDef' to 'abc_def'
        'ABCDef' to 'a_b_c_def'
    """
    words = []
    current_word = ""
    for char in name.elems():
        if char == ".":
            break
        if char.isupper() and current_word:
            words.append(current_word)
            current_word = ""
        current_word += char.lower()
    words.append(current_word)
    return "_".join(words)

def to_snake_case_with_exceptions(name):
    """ Translate a name to snake case with the execption of multiple upper case
        characters in a row.
        Will translate
        'AbcDef' to 'abc_def'
        'ABCDef' to 'abc_def'
        'ColorRBGA' to 'color_rgba'
    """
    isupper = [c.isupper() or (c == ".") for c in name.elems()]
    isupper.append(True)
    result = name[0].lower()
    for i in range(1, len(name)):
        if name[i] == ".":
            break
        if ((not isupper[i - 1] and isupper[i]) or
            (isupper[i - 1] and isupper[i] and not isupper[i + 1])):
            result += "_"
        result += name[i].lower()
    return result

def to_identifier(name):
    res = ""
    for char in name.elems():
        if char.isalnum() or char == "_":
            res += char
    return res

def extract_single_dirname(files):
    if len(files) == 0:
        fail("Empty list of files not allowed.")
    dirname = files[0].dirname
    for f in files[1:]:
        if f.dirname != dirname:
            fail("Directory names unequal.")
    return dirname
