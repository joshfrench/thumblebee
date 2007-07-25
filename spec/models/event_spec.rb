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

describe Event do
  include EventSpecHelper
  
  fixtures :events
  
  before(:each) do
    @event = Event.new
  end

  it "should not be valid" do
     @event.should_not be_valid
  end
  
  it "should have a name" do
    @event.attributes = valid_attributes.except(:name)
    @event.should_not be_valid
    @event.name = "Sample event"
    @event.should be_valid
  end
  
  it "should have a slug" do
    @event.attributes = valid_attributes.except(:slug)
    @event.should_not be_valid
    @event.should have(1).error_on(:slug)
    @event.slug = "sample"
    @event.should be_valid
  end
  
  it "should have a location" do
    @event.attributes = valid_attributes.except(:location)
    @event.should_not be_valid
    @event.should have(1).error_on(:location)
    @event.location = "Timbuktu"
    @event.should be_valid
  end
  
  it "should have a contact" do
    @event.attributes = valid_attributes.except(:contact)
    @event.should_not be_valid
    @event.should have(1).error_on(:contact)
    @event.contact = "Jimmy Jimjim"
    @event.should be_valid
  end
  
  it "should have a valid email" do
    @event.attributes = valid_attributes.except(:email)
    @event.should_not be_valid
    @event.should have(1).error_on(:email)
    @event.email = 'This is not a email'
    @event.should_not be_valid
    @event.should have(1).error_on(:email)
    @event.should have(1).error_on(:email)
    @event.email = 'rideboard@vitamin-j.com'
    @event.should be_valid
    @event.should have(:no).error_on(:email)
  end
  
  it "should have a valid starts_on" do
    @event.attributes = valid_attributes.except(:starts_on)
    @event.should_not be_valid
    @event.starts_on = 'This is not a valid date'
    @event.should_not be_valid
    @event.starts_on = 'July 20'
    @event.should_not be_valid
    @event.starts_on = 'Foo 20 2007'
    @event.should_not be_valid
    @event.starts_on = 1.week.from_now.to_s :db
    @event.should be_valid
    @event.should have(:no).error_on(:starts_on)
  end
  
  it "should have a start date before now" do
    @event.attributes = valid_attributes.except(:starts_on)
    @event.starts_on = 1.day.ago.to_s
    @event.should_not be_valid
  end
  
  it "should not have a start date later than 1 year from now" do
    @event.attributes = valid_attributes.except(:starts_on)
    @event.starts_on = 366.days.from_now.to_s
    @event.should have(1).error_on(:starts_on)
    @event.should_not be_valid
    @event.starts_on = 365.days.from_now.to_s
    @event.should be_valid
  end
  
  it "should use slug as param" do
    @event.slug = 'sampleslug'
    @event.to_param.should eql("sampleslug")
  end
  
  it "should list available rides" do
    ride = Ride.new(:seats => 0)
    open_ride = Ride.new(:seats => 2)
    @event.should_receive(:rides).and_return([ride, open_ride])
    @event.available_rides.should include(open_ride)
  end
  
  it "should not list rides with no seats" do
    ride = Ride.new(:seats => 0)
    open_ride = Ride.new(:seats => 2)
    @event.should_receive(:rides).and_return([ride, open_ride])
    @event.available_rides.should_not include(ride)
  end
  
  it "should delete expired events" do
    expire = events(:two)
    Event.should have(2).records
    Event.delete_expires
    Event.should have(1).record
    Event.find(:all).should_not include(expire)
  end
  
  
end