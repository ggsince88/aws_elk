#
# Cookbook:: aws_elk
# Recipe:: elastic
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

# Create user for elasticsearch service. Never run as root.
elasticsearch_user 'elasticsearch' do
	username 'elasticsearch'
	groupname 'elasticsearch'
	shell '/bin/bash'
	action :create
end

# Install elasticsearch. Freeze version
elasticsearch_install 'elasticsearch' do
	version '5.3.0'
	action :install
end

# Configure elasticsearch.yml
# TODO Use attr/vars for configuration resource
elasticsearch_configure 'elasticsearch' do
	configuration ({
		'node.name' => node.name,
		'network.host' => 'localhost'
	})
	action :manage
end

# Enable service to start on boot and start the service
elasticsearch_service 'elasticsearch'


