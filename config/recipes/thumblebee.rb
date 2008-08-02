require 'rubygems'
require 'active_support/core_ext/hash/indifferent_access'

Capistrano::Configuration.instance.load do
  
  module Thumblebee
    module CapUtil
      def get_db_config(env='production')
        yaml = capture('cat ' + File.join(current_path, %w(config database.yml)))
        config = YAML::load(yaml)
        HashWithIndifferentAccess.new { |hash,key| hash[key] = config[env.to_s][key] }
      end
    end
  end
  
  Capistrano.plugin :thumblebee, Thumblebee::CapUtil

end
