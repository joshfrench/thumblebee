require File.dirname(__FILE__) + '/../spec_helper'

describe RideMailer do
  fixtures :all
  
  before do
    ActionMailer::Base.delivery_method = :test 
    ActionMailer::Base.perform_deliveries = true 
    ActionMailer::Base.deliveries = []
    @ride = rides(:available)
    @event = events(:active)
  end
  
  it "should send a new-ride email" do
    response = RideMailer.create_new_ride(@ride)
    response.to.should   include(@ride.email)
    response.from.should include(@event.email)
    response.body.should match(/#{@ride.driver}/)
    response.body.should match(/#{@event.name}/)
    response.body.should match(/#{@event.slug}\/rides\/#{@ride.auth}/)
  end
end