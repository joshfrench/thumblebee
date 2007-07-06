class RidesController < ApplicationController
  
  def create
    @event = Event.find_by_slug(params[:event_id])
    @ride = @event.rides.build(params[:ride])
    @ride.save!
    flash[:message] = "Thanks for posting your ride."
    redirect_to default_path(@event)
  rescue
    render :template => "events/show"
  end
  
  def show
    @ride = Ride.find_by_auth(params[:id])
    @event = @ride.event
  end
  
  def update
    @ride = Ride.find_by_auth(params[:id])
    @event = @ride.event
    @ride.update_attributes(params[:ride])
    @ride.save!
    flash[:message] = "Your changes have been saved." 
    redirect_to default_path(@ride.event)
  rescue
    render :action => :show
  end
  
end