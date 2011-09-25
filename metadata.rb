maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "LWRP to install Mac OS X applications from zip archives"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.2"

supports "mac_os_x"

recipe "zip_app", "Processes a list of *zip_apps* (which is emtpy by default) to be installed."
recipe "zip_app::data_bag", "Fetches an list of *zip_apps* from a data bag item and sets the `node['zip_app']['apps']` attribute for processing."
