class EventsController < ApplicationController
  
  def new
    @event = Event.new
    @event.starts_on = Time.now
  end
  
  def create
    @event = Event.create(params[:event])
    redirect_to event_path(@event)
  rescue
    render :action => :new
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
end