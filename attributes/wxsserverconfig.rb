# Cookbook Name:: wxs
# Attributes:: default_server
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

#<> Defines `defaultServer` server instance. 

default[:wxs][:servers][:defaultServer] = {
  "enabled" => true,
  "serverName" => "defaultServer",
  "catalogServer" => true,
  "mBeansEnabled" => true,
  "minimumThreadPoolSize" => "10",
  "maximumThreadPoolSize" => "50",
  "catalogServiceBootstrap" => "localhost:2809",
  "memoryThresholdPercentage" => "-1",
  "statsSpecification" => "all=disabled",
  "enableXM" => false,
  "quorum" => false,
  "heartBeatFrequencyLevel" => "0",
  "placementDeferralInterval" => "15000"    
}

