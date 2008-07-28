class RidesController < ApplicationController
  include CacheableFlash
  
  def create
    @event = Event.find_by_slug(params[:event_id])
    @ride = @event.rides.build(params[:ride])
    @ride.save!
    flash[:message] = "Thanks for posting your ride."
    redirect_to default_path(@event)
  rescue
    @event.rides.delete(@ride) unless @event.rides.nil?
    flash.now[:errors] = true
    render :template => "events/show"
  end
  
  def show
    if @ride = Ride.find_by_auth(params[:id])
      @event = @ride.event
    else
      raise ActiveRecord::RecordNotFound
    end
  end
  
  def update
    if @ride = Ride.find_by_auth(params[:id])
      begin
        @event = @ride.event
        @ride.update_attributes!(params[:ride])
        flash[:message] = "Your changes have been saved." 
        redirect_to default_path(@ride.event)
      rescue
        render :action => :show
      end
    else
      raise ActiveRecord::RecordNotFound
    end
  end
  
end