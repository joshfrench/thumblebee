require File.dirname(__FILE__) + '/../spec_helper'

describe "A valid GET/show" do
  controller_name :rides
  
  before(:each) do
    @ride = mock("ride")
    @event = mock("event")
    @ride.stub!(:event).and_return(@event)
    Ride.should_receive(:find_by_auth).with('foo').and_return(@ride)
    get :show, { :event_id => 'event', :id => 'foo' }
  end
  
  it "should return a @ride from model" do
    assigns[:ride].should equal(@ride)
  end
  
  it "should populate @event with ride's event" do
    assigns[:event].should equal(@event)
  end
  
end

describe "An invalid GET/show" do
  controller_name :rides
  
  it "should raise an error" do
    Ride.should_receive(:find_by_auth).with('foo').and_return(nil)
    lambda {
      get :show, { :event_id => 'event', :id => 'foo' }
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
  
end

describe "A valid POST/create" do
  controller_name :rides

  before(:each) do
    @event = mock("event")
    @ride = mock("ride")
    @ride.stub!(:save!).and_return(true)
    @event.stub!(:rides)
    @event.rides.stub!(:build).and_return(@ride)
    Event.should_receive(:find_by_slug).and_return(@event)
    post 'create', { :event_id => 'foo', :ride => {} }
  end
  
  it "should find the associated event" do
    assigns[:event].should equal(@event)
  end
  
  it "should build a new ride" do
    assigns[:ride].should equal(@ride)
  end
  
  it "should set flash[:message]" do
    cookies['flash'].should_not be_nil
  end
  
  it "should redirect to event path" do
    response.should be_redirect
  end
end

describe "An invalid POST/create" do
  controller_name :rides

  it "should re-render events/show" do
    @event = mock("event")
    @event.stub!(:rides)
    @ride = mock("ride")
    @event.rides.stub!(:build).and_return(@ride)
    @ride.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid)
    Event.should_receive(:find_by_slug).and_return(@event)
    
    post 'create', { :event_id => 'foo', :ride => {} }
    assigns[:ride].should equal(@ride)
    response.should render_template("events/show")
  end
end

describe "A POST to update" do
  controller_name :rides
  
  before(:each) do
    @ride = mock("ride")
    @event = mock("event")
    @ride.stub!(:event).and_return(@event)
    @ride.stub!(:update_attributes!).and_return(@ride)
  end
  
  it "with valid params should find proper ride" do
    Ride.should_receive(:find_by_auth).and_return(@ride)
    post :update, { :event_id => "foo", :id => 'bar', :ride => {} }
    assigns[:ride].should equal(@ride)
  end
  
  it "with valid params should set flash" do
    Ride.should_receive(:find_by_auth).and_return(@ride)
    post :update, { :event_id => "foo", :id => 'bar', :ride => {} }
    cookies['flash'].should_not be_nil
  end
  
  it "with valid params should redirect" do
    Ride.should_receive(:find_by_auth).and_return(@ride)
    post :update, { :event_id => "foo", :id => 'bar', :ride => {} }
    response.should be_redirect
  end
  
  it "with invalid params should raise an error" do
    Ride.should_receive(:find_by_auth).and_return(@ride)
    @ride.should_receive(:update_attributes!).and_raise(ActiveRecord::RecordInvalid)
    post :update, { :event_id => "foo", :id => 'bar', :ride => {} }
    response.should render_template(:show)
  end
  
  it "with a non-existant ride should raise an error" do
    Ride.should_receive(:find_by_auth).and_return(nil)
    lambda {
      post :update, { :event_id => "foo", :id => 'bar', :ride => {} }
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
    
end