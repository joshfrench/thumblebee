set :application, "thumblebee.com"
set :scm, :git
set :repository, "git@thumblebee.com:rideboard.git"
set :branch, "master"
set :deploy_via, :remote_cache

role :web, application
role :app, application
role :db,  application, :primary => true

set :deploy_to, "/var/www/thumblebee.com"
set :user,      "josh"
set :keep_releases, 5 

default_run_options[:pty] = true

Dir.new(File.join(File.dirname(__FILE__), 'recipes')).entries.sort.each do |entry|
  require "config/recipes/#{entry}" if entry =~ /\.rb$/
end

[:god, :passenger, :haml, :chronic, 
 :packet, :backupgem, { :rails => '2.1' }].each do |gem|
if gem.is_a?(Hash)
  name, version = gem.shift
  depend :remote, :gem, name, version
else
  depend :remote, :gem, gem, '>=0'
end
