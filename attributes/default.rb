# Attributes
#

# Java attributes for Java cookbook
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = 'true'
default['java']['oracle']['jdk']['8']['url'] = 'https://s3-us-west-2.amazonaws.com/ewsiso-oregon/jdk-8u131-linux-x64.tar.gz'

default['aws_elk']['kibana']['server_host'] = 'localhost'
default['aws_elk']['kibana']['nginx']['server_name'] = 'servername'
