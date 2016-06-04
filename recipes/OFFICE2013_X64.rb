#
# Cookbook Name:: msoffice
# Recipe:: default
#
# Copyright 2016, Michael Vershinin
#
# All rights reserved - Do Not Redistribute
#

extracted_dir = 'OFFICE2013_X64'
src = node['msoffice']['source']
Chef::Log.info("#### The src is: #{src} #####")

ver = '15.0.4569.1506'
name = 'Microsoft Office Professional Plus 2013'

# Downloads package
windows_zipfile "#{Chef::Config[:file_cache_path]}\\#{extracted_dir}" do
	source src
	action :unzip
	overwrite true
end

# Creates template for config.xml file
template "#{Chef::Config[:file_cache_path]}\\config.xml" do
	source "config.xml"
	variables({
				:volume => node['msoffice']['volume']
			 })
	action :create
end

# Installs package
config_path = (node['msoffice']['volume'] == nil) ? "\\#{extracted_dir}\\proplus.ww" : ""

windows_package name do
	version ver
	installer_type :custom
	source "#{Chef::Config[:file_cache_path]}\\#{extracted_dir}\\setup.exe"
	options "/config #{Chef::Config[:file_cache_path]}#{config_path}\\config.xml"
	timeout 14000
end

# Delete config.xml file
file "#{Chef::Config[:file_cache_path]}\\config.xml" do
	action :delete
end

# Delete downloaded zip file
file "#{Chef::Config[:file_cache_path]}\\#{extracted_dir}.zip" do
	action :delete
end

# Delete unzipped directory 
directory "#{Chef::Config[:file_cache_path]}\\#{extracted_dir}" do
	recursive true
	action :delete
end
