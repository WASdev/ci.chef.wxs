#
# Cookbook Name:: wxs
# Recipe:: default
#
# Copyright 2013, (C) Copyright IBM Corporation 2013.
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

# chef-repo/cookbooks/wxs/recipes/default.rb

# install Liberty

# Find user and group
wxs_user = node[:wlp][:user]
wxs_group = node[:wlp][:group]

Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wxs_user: #{wxs_user}")
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wxs_group: #{wxs_group}")

# Find the base dir 
wxs_base_dir = node[:wlp][:base_dir]

Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wxs_base_dir: #{wxs_base_dir}")

## Prereq Section
# Prereq -Ensure all Licenses - for now both Liberty and WXS Licenses are accepted, 
both_licenses_accepted=false

wlp_licenses_accepted= node[:wlp][:archive][:accept_license] ? true :false
wxs_licenses_accepted= node[:wxs][:archive][:accept_license] ? true :false
wlp_product_name = node[:wxs][:wlp_product_name]
wxs_product_name = node[:wxs][:wxs_product_name]
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wlp_product_name: #{wlp_product_name}")
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wxs_product_name: #{wxs_product_name}")

unless (wlp_licenses_accepted && wxs_licenses_accepted)
  license_not_accepted_array=Array.new
  if !wlp_licenses_accepted; license_not_accepted_array << "wlp" end
  if !wxs_licenses_accepted; license_not_accepted_array << "wxs" end
  
  error_message = "You must accept the license to install both " +  wlp_product_name \
  + " and " + wxs_product_name + ". " \
  + "You have not accepted " \
    
  first_time = true 
  my_string = String.new 

  license_not_accepted_array.each do |element|
    Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. element: #{element}")
    Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. first_time: #{first_time}")
    if (first_time)
      my_string = license_not_accepted_array.length>1? "licenses for: " : "license for: "
      first_time = false
    end	 

    if element.eql?"wlp"  
      if (my_string.length>14)	    
        my_string += "; " + wlp_product_name
      else	  
        my_string += wlp_product_name
      end
    elsif element.eql?"wxs"  
      if (my_string.length>14)
        my_string += "; " + wxs_product_name
      else	  
        my_string += wxs_product_name
      end  
    end
  end
  error_message += my_string
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. error_message: #{error_message}")
  #raise error_message
end
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. All licenses were accepted.")

# Prereq - Download location
unless node[:wxs][:archive][:base_url]
  error_message = "You must specify - 1) the base URL location to download install media for: " + wxs_product_name
  unless node[:wlp][:archive][:base_url]
    error_message += ". - 2) the base URL location to download install media for: " + wlp_product_name
  end
  raise error_message
end

# If a WLP download location is not set, set it to same location as WXS #Override base URL
unless node[:wlp][:archive][:base_url]
  original_wlp_base_url=node[:wlp][:archive][:base_url]
  node.override[:wlp][:archive][:base_url]=node[:wxs][:archive][:base_url]
end

wxs_base_url=node[:wxs][:archive][:base_url]
wlp_base_url=node[:wlp][:archive][:base_url]
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wxs_base_url: #{wxs_base_url}")
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wlp_base_url: #{wlp_base_url}")

# Find out if Java will be installed
if node[:wlp][:install_java]
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. Java will be installed by this recipe.")
end

# Install Liberty
# Set the install method 
org_wlp_install_method=node[:wlp][:install_method]

wlp_install_method='archive'
if not (node[:wlp][:install_method] == wlp_install_method)
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. org_wlp_install_method  #{org_wlp_install_method}\
   has been changed to: #{wlp_install_method}")
  node.override[:wlp][:install_method]=wlp_install_method
end
wlp_install_method = node[:wlp][:install_method]
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wlp_install_method: #{wlp_install_method}")

# If a WLP download location is not set, set it to same location as WXS #Override runtime URL
unless original_wlp_base_url
  org_wlp_runtime_url=node[:wlp][:archive][:runtime][:url]
  wlp_runtime_file=org_wlp_runtime_url[1,org_wlp_runtime_url.length-1]
  node.override[:wlp][:archive][:runtime][:url]=wxs_base_url + "/" + wlp_runtime_file
  wlp_runtime_url=node[:wlp][:archive][:runtime][:url]
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wlp_runtime_url: #{wlp_runtime_url}")
end

# If a WLP download location is not set, set it to same location as WXS  #Override extended URL
unless original_wlp_base_url
  org_extended_url=node[:wlp][:archive][:extended][:url]
  wlp_extended_file=org_extended_url[1,org_extended_url.length-1]
  node.override[:wlp][:archive][:extended][:url]=wxs_base_url + "/" + wlp_extended_file
  wlp_extended_url=node[:wlp][:archive][:extended][:url]
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wlp_extended_url: #{wlp_extended_url}")
end

#include_recipe "wlp::_#{wlp_install_method}_install" which also includes java
include_recipe "wlp"

# Download WXS
runtime_dir = "#{node[:wlp][:base_dir]}/wlp"
runtime_uri = ::URI.parse(node[:wxs][:archive][:runtime][:url])
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. runtime_uri: #{runtime_uri}")
runtime_filename = ::File.basename(runtime_uri.path)
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. runtime_filename: #{runtime_filename}")

# Fetch the WAS Liberty Profile runtime file
if runtime_uri.scheme == "file"
  runtime_file = runtime_uri.path
else
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. runtime_uri.scheme is not file")  
  runtime_file = "#{Chef::Config[:file_cache_path]}/#{runtime_filename}"
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. runtime_file: #{runtime_file}")
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. runtime_dir: #{runtime_dir}")
  
  remote_file runtime_file do  
    source node[:wxs][:archive][:runtime][:url]	
    user node[:wxs][:user]
    group node[:wxs][:group]
	my_checksum=node[:wxs][:archive][:runtime][:checksum]
	Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. my_checksum: #{my_checksum}")
    checksum node[:wxs][:archive][:runtime][:checksum]
    not_if { ::File.exists?(runtime_file) }
  end
end

# install WXS
 
# Install the WAS Liberty Profile
execute "install WXS binary" do
  user node[:wlp][:user]
  group node[:wlp][:group]
  cwd node[:wlp][:base_dir]
  command_to_run="java -jar #{runtime_file} --acceptLicense #{node[:wlp][:base_dir]}" 
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. command_to_run: #{command_to_run}")
  command "#{command_to_run}" 
  
  wxs_dir="#{runtime_dir}/wxs"
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. wxs_dir: #{wxs_dir}")
  not_if { ::File.exists?(wxs_dir) }
end

