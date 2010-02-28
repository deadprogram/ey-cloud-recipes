# sets the timezone to GMT for all database server instances. You need this is you want to use 
# default time zone handling in Ruby on Rails

require 'pp'
#
# Cookbook Name:: timezones
# Recipe:: default
 
link "/etc/localtime" do
  to "/usr/share/zoneinfo/GMT"
end
 
# 1:00 am PST in GMT is 17:00
cron_hour = 17
 
# Override the PST ey-snapshot
unless 'app' == node[:instance_role]
  cron "ey-snapshots" do
    minute '0'
    hour cron_hour
    day '*'
    month '*'
    weekday '*'
    command "ey-snapshots --snapshot"
    not_if { node[:backup_window].to_s == '0' }
  end
end
