# Cookbook Name:: wxs
# Attributes:: default
# WLP Product Name
default[:wxs][:wlp_product_name] = "WebSphere Application Server Liberty Profile"
# WXS product name
default[:wxs][:wxs_product_name] = "WebSphere eXtremeScale"
#<> User name under which the server will be installed and running.
default[:wxs][:user] = "wxs"

#<> Group name under which the server will be installed and running.
default[:wxs][:group] = "wxs-admin"

#<> Base Liberty installation directory.
default[:wxs][:base_dir] = "/opt/was/liberty"

#<
# Base URL location for downloading the Liberty jar, WXS jar.
#>
default[:wxs][:archive][:base_url] = nil

#<
# Accept license terms when doing archive-based installation.
# Must be set to `true` otherwise installation will fail.
#>
default[:wxs][:archive][:accept_license] = false

#<> URL location of the WXS archive.

default[:wxs][:archive][:runtime][:url] = "#{node[:wxs][:archive][:base_url]}/wxs-wlp_8.6.0.4.jar"

#<> Checksum value for the runtime archive.
default[:wxs][:archive][:runtime][:checksum] = '10f2aac92fa7647d74045aee30a44288af3a287a820b62351e8aa777355f5f20'

