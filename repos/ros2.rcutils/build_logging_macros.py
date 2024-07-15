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

import em
import argparse

if __name__ == "__main__":
    # execute only if run as a script
    parser = argparse.ArgumentParser()
    parser.add_argument("file_out", help="File to be generated")
    parser.add_argument("file_template", help="Template for the file to be filled")
    args = parser.parse_args()
    em.invoke((
        [
            '-o', args.file_out,
            # We don't need to populate rcutils_module_path as we already have rcutils imported, so
            # it will be found within the .em script. This parameter we pass (as empty) for legacy
            # reasons only to avoid changing the .em file.
            '-D', 'rcutils_module_path = \"\"',
            args.file_template
        ]
    ))
