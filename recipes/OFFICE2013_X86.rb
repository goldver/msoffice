#
# Cookbook Name:: litc-msoffice
# Recipe:: default
#
# Copyright 2016, Michael Vershinin
#
# All rights reserved - Do Not Redistribute
#

extracted_dir = 'OFFICE2013_X86'
src = "#{node['msoffice']['source']}\\#{extracted_dir}.zip"
Chef::Log.info("#### The src is: #{src} #####")

ver = '15.0.4569.1506'
name = 'Microsoft Office Professional Plus 2013'

# Detect installation by version and if it exists doesn't download .zip
$product_version = ''
main_exe = ((node['msoffice']['volume'] == nil) ? "C:\\Program Files (x86)" : "#{node['msoffice']['volume']}:") + "\\Microsoft Office\\Office15\\FIRSTRUN.EXE"

if ::File.exists?(main_exe)
    detect_version 'Product version' do 
		path main_exe
		attribute 'ProductVersion'
		return_var "$Product_version"
    end
end

# Downloads package
windows_zipfile "#{Chef::Config[:file_cache_path]}\\#{extracted_dir}" do
	source src
	action :unzip
	overwrite true
	not_if {$Product_version == "#{ver}"}	
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
	timeout 1200
end

# Delete config.xml file
file "#{Chef::Config[:file_cache_path]}\\config.xml" do
	action :delete
end

# Delete downloaded zip file
file "#{Chef::Config[:file_cache_path]}\\#{File.basename(src)}" do
	action :delete
end

# Delete unzipped directory 
directory "#{Chef::Config[:file_cache_path]}\\#{extracted_dir}" do
	recursive true
	action :delete
end
