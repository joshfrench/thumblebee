class RidesController < ApplicationController
  
  def create
    @event = Event.find_by_slug(params[:event_id])
    @ride = @event.rides.build(params[:ride])
    @ride.save!
    redirect_to event_path(@event)
  rescue
    render :template => "events/show"
  end
  
end