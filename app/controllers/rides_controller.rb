class RidesController < ApplicationController
  before_filter :login_required, :except => :create
  
  def create
    @event = Event.find_by_slug(params[:event_id])
    @ride = @event.rides.build(params[:ride])
    if @ride.save
      flash[:updated] = @ride.id
      redirect_to default_path(@event, :anchor => @ride.id)
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
      redirect_to default_path(@ride.event, :anchor => @ride.id)
    else
      render :action => 'show'
    end
  end
  
  private
    def authorized?
      current_ride.auth == params[:id]
    end
  
    def login_required
      if @ride = Ride.find_by_auth(params[:id])
        @event = @ride.event
        return (logged_in? && authorized?) || access_denied
      else
        raise ActiveRecord::RecordNotFound
      end
    end
end