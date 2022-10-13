# Copyright 2022 Apex.AI, Inc.
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

def create_visibility_control_h(ctx, cfg, *, output_filename):
    for _dirname in cfg.dirnames:
        visibility_control_h = ctx.actions.declare_file(cfg.output_dir_relative + "/" + _dirname + "/" + output_filename)
        cfg.outputs.append(visibility_control_h)
        ctx.actions.expand_template(
            template = ctx.file._visibility_control_h_in,
            output = visibility_control_h,
            substitutions = {
                "@PROJECT_NAME_UPPER@": cfg.package_name.upper(),
                "@PROJECT_NAME@": cfg.package_name,
            },
        )
