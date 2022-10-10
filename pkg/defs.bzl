load("@rules_pkg//pkg:tar.bzl", _pkg_tar = "pkg_tar")
load(
    "@rules_ros//pkg/detail:ros_pkg.bzl",
    _ros_pkg = "ros_pkg",
    _ros_pkg_set = "ros_pkg_set",
)
load(
    "@rules_ros//pkg/detail:ros_archive.bzl",
    _ros_archive_install_command = "ros_archive_install_command",
    _ros_archive_pkg_files = "ros_archive_pkg_files",
)

ros_pkg = _ros_pkg
ros_pkg_set = _ros_pkg_set

def ros_archive(*, name, ros_pkgs, **kwargs):
    """ Creates a ros install package

    A tar archive is created

    Keyword arguments:
    name -- target name
    deps -- label list of ros_pkg targets
    """
    _ros_archive_pkg_files(
        name = "_{name}_pkg_files".format(name = name),
        ros_pkgs = ros_pkgs,
    )
    _pkg_tar(
        name = name,
        package_dir = name,
        srcs = [":_{name}_pkg_files".format(name = name)],
        **kwargs
    )
    _ros_archive_install_command(
        name = "{name}.install".format(name = name),
        pkg_archive = ":{name}".format(name = name),
        group_name = name,
    )
