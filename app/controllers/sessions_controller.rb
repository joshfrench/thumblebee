class SessionsController < ApplicationController
  before_filter :get_event
    
  def new
    flash.now[:errors] = false
  end
  
  def create
    if (@ride = Ride.find_by_auth(params[:id])) && @ride.email == params[:email]
      self.current_ride = @ride
      redirect_to ride_path(:event_id => @ride.event.slug, :id => @ride.auth)
    else
      flash.now[:errors] = true if request.post?
      render :action => 'new'
    end
  end
  
  protected
  
    def get_event
      @event = Event.find_by_slug(params[:event_id])
    end

end