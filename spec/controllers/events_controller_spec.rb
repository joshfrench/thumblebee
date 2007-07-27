require File.dirname(__FILE__) + '/../spec_helper'

module EventSpecHelper
  def valid_attributes
    { :name => 'Sample Event',
      :slug => 'sample',
      :email => 'sample@vitamin-j.com',
      :contact => 'Sample Contact',
      :location => 'Timbuktu',
      :starts_on => 2.weeks.from_now.to_s(:db) }
  end
end

describe 'A GET to /new' do
  controller_name :events
  
  it "should create a new record with today's date" do
    @event = mock('event')
    Event.should_receive(:new).and_return(@event)
    @event.should_receive(:starts_on=).with(Date.today)
    
    get :new
    assigns[:event].should equal(@event)
  end
  
end

describe 'A valid POST to create' do
  include EventSpecHelper
  controller_name :events
  
  before(:each) do
    @event = mock("event")
    @event.should_receive(:save!).and_return(@event)
    Event.should_receive(:new).and_return(@event)
    post 'create', { :event => {} }
  end
  
  it "should request a new Event model on Post->Create" do
    assigns[:event].should equal(@event)
  end
  
  it "should redirect to event's URL" do
    response.should be_redirect
  end
end

describe "An invalid POST to create" do
  controller_name :events
  
  before(:each) do
    @event = mock("event")
    @event.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid)
    Event.should_receive(:new).and_return(@event)
    post 'create', { :event => {} }
  end
  
  it "should render events/new" do
    response.should render_template :new
  end
  
  it "should populate an object with errors" do
    assigns[:event].should equal(@event)
  end

end

describe 'A GET to /demoslug' do
  controller_name :events
  
  before(:each) do
    @event = mock("event")
    Event.should_receive(:find_by_slug).with('demoslug').and_return(@event)
    
    @ride = mock('ride')
    @ride.should_receive(:seats=).with(3)
    Ride.should_receive(:new).and_return(@ride)
    
    get :show, :id => 'demoslug'
  end
  
  it "should get an event with slug == demoslug from model" do
    assigns[:event].should equal(@event)
  end
  
  it "should set up a new ride" do
    assigns[:ride].should equal(@ride)
  end
  
end

describe 'A request for a bogus slug' do
  controller_name :events
  
  before(:each) do
    Event.stub!(:find)
  end
  
  it "should not assign an @event" do
    lambda {
      get :show, :id => 'notaslug'
      assigns[:event].should be_nil
    }.should raise_error
  end
  
  it "should not assign a @ride" do
    lambda {
      get :show, :id => 'notaslug'
      assigns[:ride].should be_nil
    }.should raise_error
  end
  
  it "should raise an error" do
    lambda {
      get :show, :id => 'notaslug'
      response.should be_error
    }.should raise_error
  end
  
end