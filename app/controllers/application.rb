# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  include CacheableFlash
  cache_sweeper :event_sweeper
  helper_method :event_cache_key
  
  protected
  def event_cache_key(event)
    "#{request.host_with_port}/events/#{event.slug}"
  end
end
