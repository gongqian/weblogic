#
# Cookbook Name:: weblogic
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_attribute "java"

bea_home = node['weblogic']['bea_home']
java_home = node['java']['java_home']
installer = node['weblogic']['installer']

if File.exists?(bea_home)
  Chef::Log.info("#{bea_home} already exists.....not installing WebLogic")
else
  Chef::Log.info("#{bea_home} does not exist")

  tmp_dir = "c:\\temp"
  silentxml = "#{tmp_dir}\\silent.xml"

  directory tmp_dir do
    action :create
  end

  template silentxml do
    source "silent.xml.erb"
  end

  execute "weblogic" do
    Chef::Log.info("installer=#{installer}")
    command "#{installer} -mode=silent -silent_xml=#{silentxml} -log=#{tmp_dir}\\silent.log"
    action :run
  end
end

