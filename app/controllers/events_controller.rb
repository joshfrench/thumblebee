class EventsController < ApplicationController
  
  def new
    @event = Event.new
    @event.starts_on = Date.today
  end
  
  def create
    @event = Event.create(params[:event])
    redirect_to @event
  rescue
    render :action => :new
  end
  
  def show
    @event = Event.find_by_slug(params[:id])
    @ride = Ride.new
    @ride.leave_at = @event.starts_on
    @ride.return_at = @event.starts_on + 1
  end
  
end