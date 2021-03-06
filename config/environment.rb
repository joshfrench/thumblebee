# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
# RAILS_GEM_VERSION = '1.2.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  config.frameworks -= [ :action_web_service ]

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :cookie_store
  config.action_controller.session = { :session_key => "thumblebee_data", :secret => "87U402SJN31120000L122U0212020702NU84101LJS2U" }

  # Activate observers that should always be running
  config.active_record.observers = :ride_observer
  
end

Date::DATE_FORMATS[:nice] = "%B %d, %Y"
ActionMailer::Base.default_url_options[:host] = 'thumblebee.com'