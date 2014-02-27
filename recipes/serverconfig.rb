# Cookbook Name:: wxs
# Attributes:: serverconfig
#
# (C) Copyright IBM Corporation 2013.
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

=begin

=end

#Find user and user group directory is owned by (Objectgrid.xml and Objectgriddeployment.xml)
wlp_user = node[:wlp][:user]
wlp_group = node[:wlp][:group]

Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. user: #{wlp_user}; group: #{wlp_user}")

utils = Liberty::Utils.new(node)
userDirectory = utils.userDirectory
servers_dir = utils.serversDirectory

#Find user and servers directory
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. userDirectory: #{userDirectory}")
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. servers_dir: #{servers_dir}")

Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. Start dumping all the WLP servers defined")
node[:wlp][:servers].each_pair do |key, value| 
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. key: #{key}")
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. value: #{value}")
  map = value.to_hash()
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. class of map: #{map.class}")
  #Print the map
  map.each_pair do  |map_key, map_value|
    Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. map_key: #{map_key} and has value: #{map_value}")
  end

end
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. Done dumping all the WLP servers defined")
#is there a wxs server defined?
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. Dumping all the WXS servers defined")
node[:wxs][:servers].each_pair do |key, value| 
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. key: #{key}")
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. value: #{value}")
  map = value.to_hash()
  Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. class of map: #{map.class}")
  #Print the map
  map.each_pair do  |map_key, map_value|
    Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. map_key: #{map_key} and has value: #{map_value}")
  end

end

Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. Done dumping all the WXS servers defined")

# In order of priority where do we look for the configuration of this server and the grids
# 1) Properties on the node in Chef
# 2) Local XML file
# 3) URL passed in
# 4) default

@utils = Liberty_WXS::Utils.new(node)

servers_dir = @utils.serversDirectory
Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. servers_dir: #{servers_dir}")

myconfigMethodToUse= @utils.configMethodToUse
#Chef::Log.info("Cookbook name: #{cookbook_name}, recipe name: #{recipe_name}. Done dumping all the WXS servers defined")

=begin

template '/tmp/message' do 
  source 'xsServerTemplate.erb' 
  variables( 
	isCatalogServer: 'catalogServer',
    are_mBeansEnabled: 'catalogServer',
    minimumThreadPoolSize: 'catalogServer',
    maximumThreadPoolSize: 'catalogServer',
    catalogServiceBootstrap: 'catalogServer',
    memoryThresholdPercentage: 'catalogServer',
    statsSpecification: 'catalogServer',
    isXMenabled: 'catalogServer',
    isQuorumEnabled: 'catalogServer',
    heartBeatFrequencyLevel: 'catalogServer',
    placementDeferralInterval: 'catalogServer',
  ) 
end



template '/tmp/message' do 
  source 'xsServerTemplate.erb' 
  variables( 
	isCatalogServer: 'catalogServer',
    are_mBeansEnabled: 'catalogServer',
    minimumThreadPoolSize: 'catalogServer',
    maximumThreadPoolSize: 'catalogServer',
    catalogServiceBootstrap: 'catalogServer',
    memoryThresholdPercentage: 'catalogServer',
    statsSpecification: 'catalogServer',
    isXMenabled: 'catalogServer',
    isQuorumEnabled: 'catalogServer',
    heartBeatFrequencyLevel: 'catalogServer',
    placementDeferralInterval: 'catalogServer',
  ) 
end



=end

