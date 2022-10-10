# Copyright 2021 Apex.AI, Inc.
# All rights reserved.

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
