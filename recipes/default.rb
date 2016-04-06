#
# Cookbook Name:: msoffice
# Recipe:: default
#
# Copyright 2016, Michael Vershinin
#
# All rights reserved - Do Not Redistribute
#

if node['msoffice']['version'].is_a?(String) then # Converts string for array for loop using
	node.set['msoffice']['version'] = [node['msoffice']['version']]
end

recipe_path = "#{Chef::Config[:cookbook_path][0]}\\msoffice\\recipes\\"

node['msoffice']['version'].each do |version|
	if ::File.exists?("#{recipe_path}#{version}.rb") 	
		include_recipe "msoffice::#{version}"
	else
		Chef::Log.info  "### Unsupported MS Office version #{version} ###"
	end
end

Chef::Log.info("#########################################################################################")
Chef::Log.info("###                                                                                   ###")
Chef::Log.info("###                                                                                   ###")
Chef::Log.info("###                                                                                   ###")
Chef::Log.info("#########################################################################################")