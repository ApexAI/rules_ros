load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

ROS_PROJECT = "https://github.com/ros2/ros2.git"

_VERSIONS = [
    ("humble", "20230925", "57495eab51338591a0117b6763827607808e26344d134d6666ded66e479bdf8b"),
    ("iron", "20230912", "fd40b4d80eb9c27f57b2b59ad8a947cd5f7f34fc67c8df1d7cc0a659127fc9f7"),
    ("foxy", "20230620", "2cf7e3f9c5b01b7de2ec3c80097837758f3554e4f5c99a2aeca2bd7f4eb0bc1f"),
    ("galactic", "20221209", "fd251be0e1d16c1f943a8f083dce7b75c60fc2095404c5834209a68846be48c7"),
    ("eloquent", "2020-1212", "76f4b08bc4ecc6b126d2bdf5e8b86fa3d4b6d5101c122f7d0fd973aa77ef819a"),
    ("dashing", "20210610", "f0e00b81e93f764bef7591b0d9e3b89d73660696764663f18f926cd9795028c9"),
]

_URL_TEMPLATE = "https://github.com/ros2/ros2/archive/refs/tags/release-{}-{}.tar.gz"
_STRIP_PREFIX_TEMPLATE = "ros2-release-{}-{}"

DISTROS = {
    distro: dict(
        repo_rule = http_archive,
        url = _URL_TEMPLATE.format(distro, date),
        strip_prefix = _STRIP_PREFIX_TEMPLATE.format(distro, date),
        sha256 = sha,
        repo_index = "@rules_ros//repos/config:ros2_{}.lock".format(distro),
    )
    for distro, date, sha in _VERSIONS
}
