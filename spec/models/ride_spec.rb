require File.dirname(__FILE__) + '/../spec_helper'

module RideSpecHelper
  def valid_attributes
    { :driver => 'Jimmy Driver',
      :email => 'jimmy@vitamin-j.com',
      :location => 'Park Slope',
      :seats => '3' }
  end
end

describe Ride do
  include RideSpecHelper
  fixtures :events
  
  before(:each) do
    @ride = Ride.new
  end
  
  it "should not be valid by default" do
    @ride.should_not be_valid
  end
  
  it "should list 1-6 seats when new" do
    @ride.stub!(:new_record?).and_return(true)
    @ride.min_seats.should equal(1)
  end
  
  it "should list 0-6 seats when an existing record" do
    @ride.stub!(:new_record?).and_return(false)
    @ride.min_seats.should equal(0)
  end
  
  it "should require a driver name" do
    @ride.attributes = valid_attributes.except(:driver)
    @ride.should_not be_valid
    @ride.should have(1).error_on(:driver)
    @ride.driver = "Driver Name"
    @ride.should be_valid
  end
  
  it "should require a valid email" do
    @ride.attributes = valid_attributes.except(:email)
    @ride.should_not be_valid
    @ride.should have(1).error_on(:email)
    @ride.email = "valid@vitamin-j.com"
    @ride.should be_valid
  end
  
  it "should require a departure location" do
    @ride.attributes = valid_attributes.except(:location)
    @ride.should_not be_valid
    @ride.should have(1).error_on(:location)
    @ride.location = "Park Slope"
    @ride.should be_valid
  end
  
  it "should require numeric seats value" do
    @ride.attributes = valid_attributes.except(:seats)
    @ride.should_not be_valid
    @ride.should have(1).error_on(:seats)
    @ride.seats = "A"
    @ride.should_not be_valid
    @ride.should have(1).error_on(:seats)
    @ride.seats = "1"
    @ride.should be_valid
  end
  
  it "should assign its own auth key" do
    @ride.attributes = valid_attributes
    @ride.stub!(:event).and_return(events(:one))
    @ride.save
    @ride.auth.should_not be_nil
  end
  
  it "should always return a unique auth key" do
    other_ride = mock('other-ride')
    other_ride.stub!(:auth).and_return('1234567890ABCDEFGHIJ')
    Ride.should_receive(:find).and_return([other_ride])
    @ride.attributes = valid_attributes
    @ride.auth = '1234567890ABCDEFGHIJ'
    @ride.stub!(:event).and_return(events(:one))
    @ride.save
    @ride.auth.should eql('1234567890ABCDEFGHIK')
  end
end