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
