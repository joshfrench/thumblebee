require File.dirname(__FILE__) + '/../spec_helper'

describe RideObserver do
  fixtures :all
  
  it "should send an email when a ride is added" do
    RideMailer.should_receive(:deliver_new_ride)
    events(:active).rides.create(rides(:available).attributes)
  end

end