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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

PYTHON_VERSION = "3.10.12"
RULES_PYTHON_VERSION = "1.5.1"
RULES_PYTHON_SHA = "fa532d635f29c038a64c8062724af700c30cf6b31174dd4fac120bc561a1a560"

def load_rules_python_repositories():
    maybe(
        name = "rules_python",
        repo_rule = http_archive,
        url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/{version}.tar.gz".format(
            version = RULES_PYTHON_VERSION,
        ),
        sha256 = RULES_PYTHON_SHA,
        strip_prefix = "rules_python-{version}".format(version = RULES_PYTHON_VERSION),
    )
