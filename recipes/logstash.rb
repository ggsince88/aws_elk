#
# Cookbook:: aws_elk
# Recipe:: logstash
#
# Copyright:: 2017, The Authors, All Rights Reserved.

yum_repository 'logstash5' do
        description 'logstash-5.x'
        baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
        gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
        enabled true
        action :create
end

package 'Install Logstash' do
	package_name 'logstash'
	version '5.3.0-1'
	action :install
end

# Template for output to elasticsearch config
template '/etc/logstash/conf.d/30-elasticsearch-output.conf' do
	source '30-elasticsearch-output.conf.erb'
	action :create
end

# Template for beats input config
template '/etc/logstash/conf.d/02-beats-input.conf' do
	source '02-beats-input.conf.erb'
	action :create
end

service 'logstash' do
	action [ :enable, :start ]
end


