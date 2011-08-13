#
# Cookbook Name:: zip_app
# Recipe:: default
#
# Copyright 2011, Fletcher Nichol
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
#

node['zip_app']['apps'].each do |app_hash|
  zip_app_package app_hash['name'] do
    %w{source zip_file destination checksum}.each do |attr|
      send(attr, app_hash[attr])  if app_hash[attr]
    end
  end
end
