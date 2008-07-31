class RidesController < ApplicationController
  before_filter :login_required, :except => :create
  
  def create
    @event = Event.find_by_slug(params[:event_id])
    @ride = @event.rides.build(params[:ride])
    if @ride.save
      flash[:updated] = @ride.id
      redirect_to default_path(@event)
    else
      @event.rides.delete(@ride) unless @event.rides.nil?
      flash.now[:errors] = true
      render :template => "events/show"
    end
  end
  
  def show
  end
  
  def update
    if @ride.update_attributes params[:ride]
      flash[:updated] = @ride.id
      redirect_to default_path(@ride.event)
    else
      render :action => 'show'
    end
  end
  
  def authorized?
    current_ride.auth == params[:id]
  end
  
end