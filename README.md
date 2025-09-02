# ROS 2 Rules for Bazel

## Overview

This repository contains all the setup, rules and build configuration to use
[Bazel](http://bazel.build) with ROS 2. As recommended by Bazel, all ROS 2 packages
are built from source. They are loaded as needed, so no a priori loading or manual version
management of ROS 2 repos (e.g., via vcs tool) is required.

The neccessary BUILD files for ROS 2 repos are injected while loading. In case Bazel gains
some traction within the ROS community, Bazel BUILD files should ideally be provided
directly by the ROS 2 repositories.

Specific rules for message generation and packaging are provided in this repository (see 
[rosidl/defs.bzl](rosidl/defs.bzl) and [pkg/defs.bzl](pkg/defs.bzl)).

## ! Current Restrictions !

This is still work in progress. Some essential parts are not complete yet.
Here is a short list of major restrictions:
* Only tested on Ubunut 20.04 Linux (x86_64). Other Linux distributions may work. Windows
  will not be supported in the foreseeable future.
* Only ROS 2 Humble is supported. Other distros may work after extending
  `@rules_ros//repos/config/defs.bzl` accordingly.
* Message generation is still incomplete. Therefore even the simplest examples will not run
  due to not yet bazelized middleware.
* Not all packages have been bazelized yet. Main focus currently lies on generating an
  install space and providing message generation support. Out of all the ROS 2 CLI commands,
  (`ros2cli`), only the `run` command is currently bazelized.
* The streamlined integration of custom packages into the repo setup is not yet available.
  Same applies to adding additional Python packages. 
  This will be added soon.

## Getting started

### Prerequisites

Bazel needs to be available. It is recommended to use [bazelisk](https://github.com/bazelbuild/bazelisk)
as the launch tool for Bazel.

### Workspace setup

Create an empty folder and add the following files to it:
* `WORKSPACE` file:

  ```python
  workspace(name = "my_first_bazel_ros_workspace")  # choose a workspace name here
  # load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
  load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

  RULES_ROS_VERSION = "xxx"  # TODO: where to find the right version
  RULES_ROS_SHA = "xxx"

  # until there is an initial release, use the following:
  git_repository(
      name = "rules_ros",
      remote = "https://github.com/ApexAI/rules_ros.git",
      branch = "main",
  )

  # after the first release, switch to this dependency 
  #https_archive(
  #    name = "rules_ros",
  #    sha256 = RULES_ROS_SHA,
  #    strip_prefix = "xxx",
  #    url = "https://github.com/ApexAI/rules_ros/archive/{}.zip".format(RULES_ROS_VERSION),
  #)

  load("@rules_ros//repos/config:defs.bzl", "configure_ros2")
  configure_ros2(distro = "humble")  # currently only Humble is supported

  load("@ros2_config//:setup.bzl", "setup")
  setup()

  load("@rules_ros//thirdparty:setup_01.bzl", "setup_01")
  setup_01()

  load("@rules_ros//thirdparty:setup_02.bzl", "setup_02")
  setup_02()

  load("@rules_ros//thirdparty:setup_03.bzl", "setup_03")
  setup_03()

  load("@rules_ros//thirdparty:setup_04.bzl", "setup_04")
  setup_04()
  ```

* `.bazelrc` file:

  ```shell
  # enable incompatible Python init mode
  build --incompatible_default_to_explicit_init_py

  # enable implementation_deps on cc_library targets
  build --experimental_cc_implementation_deps

  # set C++17 for all builds
  build --cxxopt="-std=c++17"
  build --host_cxxopt="-std=c++17"
  ```
  
* `.bazelversion` file (if `bazelisk` is being used):

  ```text
  6.5.0
  ```

### Run Bazel example

To **build** an example delivered in the `rules_ros` repository run, e.g.

```shell
bazel build @rules_ros//examples/hello_world
```

from anywhere within the workspace.

**Executing** the example can be done by calling

```shell
bazel run @rules_ros//examples/hello_world
```
Note that no sourcing is necessary. Bazel will take care of all the dependencies. 

**Deploying** a package archive to an install folder can be done by

```shell
bazel run @rules_ros//examples:rules_ros_examples.install <install_folder>
```

Now the environment is ready to work with ROS as usual. Source the package as usual with:

```shell
source <install_folder>/setup.bash
```

and run an executable with

```shell
ros2 run hello_world hello_world
```

## Features

### Python Interpreter

In this setup, a hermetic Python interpreter is included. The version is specified in
`thirdparty/python/repositories.bzl`. Python packages specified in
`thirdparty/python/requirements_lock.in` are available for use. If a package needs to be added, run

```shell
bazel run @rules_ros//thirdparty/python:requirements_lock.update
```

to pin specific versions of the dependencies. In the future there will be a possibility to
inject a customization in the WORKSPACE file.

### ROS 2 Repositories

ROS 2 repositories are made available as external dependencies with the name specified in
the `ros2.repos` file known from the original ROS 2 repository, e.g., the `ros2/rclcpp` repo
will be available as `@ros2.rclcpp` with all targets specified in the BUILD files in
`repos/config/ros2.rclcpp.BUILD`. The precise location where the build files will be injected
into the `rclcpp` repo is specified in the index file `repos/config/bazel.repos`.

Therefore, if there is a dependency on `rclcpp`, `"@ros2.rclcpp//rclcpp"` needs to be added
as a dependency in the `cc_binary` or `cc_library` target.

The exact version of a ROS 2 repository is pinned in the file `repos/config/ros2_<distro>.lock`.
This file can be updated for the configured distro by running:

```shell
bazel run @rules_ros//repos/config:repos_lock.update
```

In the future there will be a possibility to inject any customization in the WORKSPACE file.

## Adding more ROS2 repositories using custom `.repos` file

To use `rules_ros` in a workspace with a custom `.repos` file, follow these steps:

1. Create your custom `.repos` file with the desired ROS 2 repositories in your workspace.
2. Update the `WORKSPACE` file to use the `configure_repos` rule with the custom `.repos` file:

  ```python
  load("@rules_ros//repos/config:defs.bzl", "configure_repos")
  configure_repos(
      name = "<custom_config_workspace_name>",  # Required
      repos_index = "<path_to_your_custom_repos_file>",  # Required
      setup_file = "<path_to_your_custom_setup_file>",  # Required
      repos_index_overlays = [
          "<path_to_your_overlay_file_1>",
          "<path_to_your_overlay_file_2>"
      ]  # Optional
  )
  ```

  #### A few things to note:

  a. The `setup_file` needs to have the following content:

  ```python
  load("@bazel_tools//tools/build_defs/repo:utils.bzl", _maybe = "maybe")
  load("@rules_ros//repos/config/detail:git_repository.bzl", "git_repository")
  load("@rules_ros//repos/config/detail:http_archive.bzl", "http_archive")
  load("@rules_ros//repos/config/detail:new_local_repository.bzl", "new_local_repository")

  def setup():
    pass
  ```

  b. The `repos_index_overlays` field is optional and can be used to pass additional `*.repos` files declaring BUILD.bazel files to be injected into the ROS2 repositories.

3. Generate the `setup.bzl` file by running the `repos_lock.update` command:

  ```shell
  bazel run @<custom_config_workspace_name>//:repos_lock.update
  ```
4. Load the `setup.bzl`

  ```shell

  load("@<custom_config_workspace_name>//:setup.bzl", "setup")
  setup()

  ```
This will configure your workspace to use the specified additonal ROS2 repositories.
