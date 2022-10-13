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

import argparse

TEMPLATE = """#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${{BASH_SOURCE[0]}}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/{relative_resource_path}
{executable_path} $@
"""


def main():
    parser = argparse.ArgumentParser(description="Generate a wrapper for an executable.")
    parser.add_argument('output_path', type=str, help='Output path.')
    parser.add_argument('executable_path', type=str, help='Executable path.')
    parser.add_argument('relative_resource_path', type=str, help='Relative path to resource folder.')

    args = parser.parse_args()

    with open(args.output_path, "w") as out_file:
        out_file.write(TEMPLATE.format(
            executable_path = args.executable_path,
            relative_resource_path=args.relative_resource_path,
        ))


if __name__ == "__main__":
    main()
