class EventsController < ApplicationController
  
  def new
    @event = Event.new
    @event.starts_on = Date.today
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to default_url(@event)
    else
      render :action => :new
    end
  end
  
  def show
    if @event = Event.find_by_slug(params[:id])
      @ride = Ride.new
      @ride.seats = 3
    else
      raise ActiveRecord::RecordNotFound
    end
  end
  
end