require 'chef/development/ext/string'
require 'chef/development/rake/version_tasks'
require 'chef/development/rake/test_tasks'
require 'chef/development/rake/release_tasks'

ChefDevelopment::TestTasks.new
ChefDevelopment::VersionTasks.new
ChefDevelopment::ReleaseTasks.new
