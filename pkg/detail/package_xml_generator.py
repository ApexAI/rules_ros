import argparse
from jinja2 import Environment

TEMPLATE = """<?xml version="1.0"?>
<?xml-model href="http://download.ros.org/schema/package_format3.xsd" schematypens="http://www.w3.org/2001/XMLSchema"?>
<!-- Generated by //apex_tools/bazel/rules_ros2pkg:defs.bzl%ros2pkg -->
<package format="3">
    <name>{{pkg_name}}</name>
    <version>{{version}}</version>
    <description>{{description}}
    </description>
    <maintainer email="{{maintainer_email}}">{{maintainter_name}}</maintainer>
    <license>{{license}}</license>
</package>
"""


def main():
    parser = argparse.ArgumentParser(description="Generate `package.xml` for a ros package.")
    parser.add_argument('output_path', type=str, help='Output path.')
    parser.add_argument("--pkg_name", type=str, help="Name of the ros package.")
    parser.add_argument("--version", type=str, help="Version of the ros package.")
    parser.add_argument("--maintainer_email", type=str, help="Email address of package maintainer.")
    parser.add_argument("--maintainer_name", type=str, help="Name of package maintainer.")
    parser.add_argument("--license", type=str, help="License of package.")
    parser.add_argument("--description", type=str, help="Description of ros package.")

    args = parser.parse_args()

    env = Environment()
    template = env.from_string(TEMPLATE)

    with open(args.output_path, "w") as out_file:
        out_file.write(template.render(args.__dict__))


if __name__ == "__main__":
    main()