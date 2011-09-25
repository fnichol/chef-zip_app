# Description

LWRP to install Mac OS X applications from zip archives.

# Requirements

## Chef

Tested on 0.10.2 but newer and older version should work just fine. File an
[issue][issues] if this isn't the case.

## Platform

Only for `node[:platform] == "mac_os_x"` platforms. Tested on Mac OS X 10.7
(Lion) and 10.6.8 (Snow Leopard).

## Cookbooks

There are **no** external cookbook dependencies.

# Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

## From the Opscode Community Platform

To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install zip_app

## Using Librarian

The [Librarian][librarian] gem aims to be Bundler for your Chef cookbooks.
Include a reference to the cookbook in a **Cheffile** and run
`librarian-chef install`. To install with Librarian:

    gem install librarian
    cd chef-repo
    librarian-chef init
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'zip_app',
      :git => 'git://github.com/fnichol/chef-zip_app.git', :ref => 'v0.2.2'
    END_OF_CHEFFILE
    librarian-chef install

## Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-zip_app/v0.2.2

## As a Git Submodule

A common practice (which is getting dated) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-zip_app.git cookbooks/zip_app
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

## As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-zip_app/tarball/v0.2.2 | tar xfz - && \
      mv fnichol-chef-zip_app-* zip_app

# Usage

Simply include `recipe[zip_app]` in your run_list and the
`zip_app_package` resource will be available.

To use `recipe[zip_app::data_bag]`, include it in your run_list and have a
data bag called `"apps"` with an item called `"mac_os_x"` like the following:

    {
      "id"        : "mac_os_x",
      "zip_apps"  : [
        { "name"        : "iTerm",
          "source"      : "http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip",
          "checksum"    : "2afad022b1e1f08b3ed40f0c2bde7bf7cce003852c83f85948c7f57a5578d9c5"
        },
        { "name"        : "Divvy",
          "source"      : "http://mizage.com/divvy/downloads/Divvy.zip"
        }
      ]
    }

Alternatively, you can override the data bag and item by setting the
`node['zip_app']['data_bag']` attribute to some like:

    node['zip_app']['data_bag'] = ['apps', "workstation-mac"]

# Recipes

## default

Processes a list of *zip_apps* (which is emtpy by default) to be installed.

Use this recipe when you have a list of apps in `node['zip_app']['apps']` or
when all you need is the `zip_app_package` LWRP.

## data_bag

Fetches an list of *zip_apps* from a data bag item and appends it to the
`node['zip_app']['apps']` attribute for processing. This recipe then includes
the default recipe, so there is no need to explicitly include `recipe[zip_app]`.

Use this recipe when you want data bag driven data in your workflow.

# Attributes

## `apps`

An array of zip_app hashes. The keys in the hashes correspond to the attributes
passed to the `zip_app_package` LWRP. For example:

    node['zip_app']['apps'] = [
      { 'name'      => 'iTerm',
        'source'    => 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip',
        'checksum'  => '2afad022b1e1f08b3ed40f0c2bde7bf7cce003852c83f85948c7f57a5578d9c5'
      },
      { 'name'      => 'GitHub',
        'source'    => 'https://github-central.s3.amazonaws.com/mac/GitHub%20for%20Mac%201.0.6.zip',
        'checksum'  => '1e95b3c16915efe171e53c2de31ae5b0b45cca6689a6923baa96cf754a06ed73'
      }
    ]

The default is an empty Array: `[]`.

## `data_bag`

The data bag and item containing a list of apps to be installed.. This is used
by the `data_bag` recipe. The default is `['apps', node['platform']]`.

# Resources and Providers

## zip_app_package

### Actions

Action    |Description                   |Default
----------|------------------------------|-------
install   |Download and extract the `*.app` application into the destination directory. |Yes
### Attributes

Attribute   |Description |Default value
------------|------------|-------------
app         |**Name attribute:** The name of the installed application. For example, if the application to be installed was "/Application/GitHub.app" then the value would be `"GitHub"`. |`nil`
source      |The source URL of the zip archive. |`nil`
checksum    |(optional) The SHA-256 checksum of the file. If the local file matches the checksum, Chef will not download it. |`nil`
destination |The base path to where the application will be installed. |`"/Applications"`
zip_file    |(optional) The zip file name if it differs from the the last path fragment in the `source` URL. |`nil`
installed   |(internal) |`false`

### Examples

#### Install Basic App

    zip_app_package "Divvy" do
      source  "http://mizage.com/divvy/downloads/Divvy.zip"
    end

**Note:** the install action is default.

#### Install App To Custom Destination

    zip_app_package "GitHub" do
      source      "https://github-central.s3.amazonaws.com/mac/GitHub%20for%20Mac%201.0.6.zip"
      checksum    "1e95b3c16915efe171e53c2de31ae5b0b45cca6689a6923baa96cf754a06ed73"
      destination "#{ENV['HOME']}/Applications"
    end

**Note:** *GitHub.app* will be installed to `~/Applications/GitHub.app`,
and assumes that the directory exists.

# Credits

This cookbook and LWRP patterns are heavily lifted with love from the
[dmg][dmg_cb], [iterm2][iterm2_cb], [1password][1password_cb], and
[ghmac][ghmac_cb] cookbooks. Oh, and Joshua Timberman's
[workstation][workstation] blog post.

# Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

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

[1password_cb]: http://community.opscode.com/cookbooks/1password
[dmg_cb]:       http://community.opscode.com/cookbooks/dmg
[chef_repo]:    https://github.com/opscode/chef-repo
[ghmac_cb]:     http://community.opscode.com/cookbooks/ghmac
[iterm2_cb]:    http://community.opscode.com/cookbooks/iterm2
[kgc]:          https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:    https://github.com/applicationsonline/librarian#readme
[workstation]:  http://jtimberman.posterous.com/managing-my-workstations-with-chef

[repo]:         https://github.com/fnichol/chef-zip_app
[issues]:       https://github.com/fnichol/chef-zip_app/issues
