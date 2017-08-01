#
# Cookbook:: aws_elk
# Recipe:: kibana
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Load passwords from the 'passwords' data bag
passwords = data_bag_item('passwords', 'kibana')

# Kibana repo
yum_repository 'kibana5' do
	description 'kibana-5.x'
	baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
	gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
	enabled true
	action :create
end

# Nginx will proxy to kibana front end. 
package 'nginx'
package 'httpd-tools'

# Install Kibana. Freeze version
package 'Install Kibana' do
	package_name 'kibana'
	version '5.3.0-1'
	action :install
end

# Customize kibana settings. Using expression/vars in template. Use attr to keep clean/flexible 
template '/etc/kibana/kibana.yml' do
	source 'kibana.yml.erb'
	variables({
		:kib_svr_host => node['aws_elk']['kibana']['server_host']
	})
	action :create
end

# Start kibana
service 'kibana' do
	action [ :enable, :start ]
end

# Add kadmin user for basic auth on Nginx. Password stored in encryped data bag on chef server
# TODO Create attr for user 
execute 'htpasswd_setup' do
	command "/bin/htpasswd -cb /etc/nginx/htpasswd.users kadmin #{passwords['nginx_pw']}"
	not_if '/bin/grep kadmin /etc/nginx/htpasswd.users'
end

# Modify nginx.conf to load kibana.conf
template '/etc/nginx/nginx.conf' do
	source 'nginx.conf.erb'
	action :create
end

# nginx kibana.conf config file for basic auth
# TODO make var nginx_kib_svrname an attr
template '/etc/nginx/conf.d/kibana.conf' do
	source 'kibana.conf.erb'
	variables({
		:nginx_kib_svrname => node['ipaddress']
	})
	action :create
end

# Enable httpd network connections to nginx if SELinux is enabled
#execute '/sbin/setsebool -P httpd_can_network_connect 1' do
#	not_if '/sbin/sestatus -b | grep httpd_can_network_connect | grep on$'
#end

service 'nginx' do
	action [ :enable, :start ]
end




