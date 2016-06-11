#
# Cookbook Name:: aerospike-cluster
# Recipe:: monitoring-collectd
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

node.default['aerospike'][recipe_name]['plugin_dir'] = '/opt/aerospike-collectd'
node.default['aerospike'][recipe_name]['config_dir'] = '/etc/collectd.d'

Chef::Log.warn "Directory from attribute node['aerospike']['#{recipe_name}']['config_dir'], doesn't exist: #{node['aerospike'][recipe_name]['config_dir']}" unless File.exist? node['aerospike'][recipe_name]['config_dir']

package value_for_platform(
  %w(centos redhat) => { 'default' => 'PyYAML' },
  %w(ubuntu debian) => { 'default' => 'python-yaml' },
  'default' => 'PyYAML'
)

git node['aerospike'][recipe_name]['plugin_dir'] do
  repository 'https://github.com/aerospike/aerospike-collectd.git'
  reference 'master'
  action :export
end

template "#{node['aerospike'][recipe_name]['config_dir']}/aerospike.conf" do
  source 'monitoring/aerospike-collectd.conf.erb'
end
