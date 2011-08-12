# Description

LWRP to install Mac OS X applications from zip archives

# Requirements

## Chef

Tested on 0.10.2 but newer and older version should work just fine. File an
[issue][issues] if this isn't the case.

## Platform

Only for `node[:platform] == "mac_os_x"` platforms. Tested on Mac OS X 10.7
(Lion) and 10.6.8 (Snow Leopard).

## Cookbooks

There are no external cookbook dependencies.

# Usage

Simply include the `recipe[zip_app]` cookbook in your run_list and the
`zip_app_package` resource will be available.

# Recipes

## default

This recipe is a no-op and does nothing.

# Attributes

# Resources and Providers

## zip_app_package

## Actions

Action    |Description                   |Default
----------|------------------------------|-------
install   |Download and extract the `*.app` application into the destination directory. |Yes

## Attributes

Attribute   |Description |Default value
------------|------------|-------------
app         |**Name attribute:** The name of the installed application. For example, if the application to be installed was "/Application/GitHub.app" then the value would be `"GitHub"`. |`nil`
source      |The source URL of the zip archive. |`nil`
checksum    |(optional) The SHA-256 checksum of the file. If the local file matches the checksum, Chef will not download it. |`nil`
destination |The base path to where the application will be installed. |`"/Applications"`
zip_file    |(optional) The zip file name if it differs from the the last path fragment in the `source` URL. |`nil`
installed   |(internal) |`false`

## Examples

Coming soon...

# Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every seperate change you make.

# License and Author

Author:: Fletcher Nichol (<fnichol@nichol.ca>)

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[repo]:     https://github.com/fnichol/chef-zip_app
[issues]:   https://github.com/fnichol/chef-zip_app/issues
