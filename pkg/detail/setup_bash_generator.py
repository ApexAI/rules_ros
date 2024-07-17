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

import argparse

TEMPLATE = """# !/usr/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export PATH=$SCRIPT_DIR/bin:$PATH
export AMENT_PREFIX_PATH=$SCRIPT_DIR:$AMENT_PREFIX_PATH
for pythonpath in $SCRIPT_DIR/lib/python*/site-packages; do
  if [ -d "$pythonpath" ]; then
    export PYTHONPATH=$pythonpath:$PYTHONPATH
  fi
done
"""


def main():
    parser = argparse.ArgumentParser(description="Generate `setup.bash`.")
    parser.add_argument('output_path', type=str, help='Output path.')

    args = parser.parse_args()

    with open(args.output_path, "w") as out_file:
        out_file.write(TEMPLATE)


if __name__ == "__main__":
    main()
