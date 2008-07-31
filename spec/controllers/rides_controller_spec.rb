require File.dirname(__FILE__) + '/../spec_helper'

describe RidesController do
  fixtures :all
  
  before do
    @ride = rides(:available)
    @event = @ride.event
    controller.send(:current_ride=, @ride)
  end

  describe "A valid GET/show" do
  
    before do
      get :show, { :event_id => @event.slug, :id => @ride.auth }
    end
  
    it "should return set @ride" do
      assigns(:ride).should eql(@ride)
    end
  
    it "should populate @event with ride's event" do
      assigns(:event).should eql(@event)
    end
  
  end

  describe "An invalid GET/show" do
  
    it "should raise an error if no ride found" do
      lambda {
        get :show, { :event_id => @event.slug, :id => 'bogus' }
      }.should raise_error(ActiveRecord::RecordNotFound)
    end
    
    it "should redirect if no one is logged in" do
      controller.send(:current_ride=, nil)
      get :show, :event_id => @event.slug, :id => @ride.auth
      response.should redirect_to new_session_path(@event, @ride)
    end
    
    it "should redirect if user is not authorized to access this ride" do
      get :show, :event_id => @event.slug, :id => rides(:full).auth
      response.should redirect_to new_session_path(@event, rides(:full))
    end
  
  end

  describe "A valid POST/create" do

    before do
      post 'create', { :event_id => @event.slug, :ride => @ride.attributes }
    end
  
    it "should find the associated event" do
      assigns(:event).should eql(@event)
    end
  
    it "should build a new ride" do
      assigns(:ride).should be_valid
      assigns(:ride).event.should eql(@event)
    end
    
    it "should redirect to event path" do
      response.should redirect_to(default_path(@event))
    end
  end

  describe "An invalid POST/create" do

    it "should re-render events/show" do
      post 'create', { :event_id => @event.slug, :ride => {} }
      assigns(:ride).should be_new_record
      assigns(:ride).should_not be_valid
      response.should render_template("events/show")
    end
  end

  describe "PUT /update" do
  
    it "with valid params should find proper ride" do
      put :update, { :event_id => @event.slug, :id => @ride.auth }
      assigns(:ride).should eql(@ride)
    end
    
    it "with valid params should redirect" do
      put :update, { :event_id => @event.slug, :id => @ride.auth, :ride => @ride.attributes }
      response.should redirect_to(default_path(@event.slug))
    end
  
    it "with invalid params should raise an error" do
      put :update, { :event_id => @event.slug, :id => @ride.auth, :ride => { :email => nil } }
      response.should render_template('show')
    end
  
    it "with a non-existant ride should raise an error" do
      lambda {
        put :update, { :event_id => @event.slug, :id => 'bogus' }
      }.should raise_error(ActiveRecord::RecordNotFound)
    end 
  end
  
end