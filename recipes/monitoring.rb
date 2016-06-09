#
# Cookbook Name:: aerospike-cluster
# Recipe:: monitoring
#
# Copyright 2016, Oleksandr Sakharchuk
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

if node['aerospike'].attribute?('monitoring')
  raise "invalid value for node attribute node['aerospike']['monitoring'], valid are array of any combination of 'collectd'" if (%w(collectd) & node['aerospike']['monitoring']).empty?
  node['aerospike']['monitoring'].each do |method|
    include_recipe "aerospike-cluster::monitoring_#{method}"
  end
end
