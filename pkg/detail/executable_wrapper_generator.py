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
