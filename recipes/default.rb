#
# Cookbook Name:: aws_elk
# Recipe:: default
# Author: Galo Andrade
# Copyright 2017, Eastridge Workforce Solutions
#
# All rights reserved - Do Not Redistribute

# Misc packages
package 'wget'
package 'tree'
package "epel-release"
package "vim"

# Set SELinux in permissive mode but will still log.
# TODO Configure SELinux in enforcing mode and to play nice with needed services
execute '/sbin/setenforce 0' do
	not_if '/sbin/sestatus | grep "Current mode:" | grep permissive$'
end

# Java recipe to install Oracle java with custom attributes. Required by ELK
include_recipe "java"
# ELK stack in different recipes
include_recipe "aws_elk::elastic"
include_recipe "aws_elk::kibana"
include_recipe "aws_elk::logstash"

