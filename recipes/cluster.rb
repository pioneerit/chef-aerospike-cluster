#
# Author:: Blair Hamilton(blairham@me.com)
# Cookbook Name:: aerospike-cluster
# Recipe:: cluster
#
# Copyright:: Copyright (c) 2015, Blair Hamilton
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

# Get a list of all the
nodes = search(:node, node['aerospike']['chef']['search'].to_s)
nodes.sort_by! { |n| n['ipaddress'] }
nodes.map! { |n| "#{n['ipaddress']} #{n['aerospike']['config']['network']['heartbeat']['port']}" }

node.default['aerospike']['config']['network']['heartbeat']['mesh-seed-address-port'] = nodes