require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  fixtures :all
  
  before do
    @ride = rides(:available)    
  end
  
  describe "with valid params" do
    before do
      post :create, :event_id => @ride.event.id, :id => @ride.auth, 
                    :email => @ride.email
    end
    
    it "should set @current_ride" do
      controller.send(:current_ride).should eql(@ride)
    end
    
    it "should redirect to ride path" do
      response.should redirect_to(
        ride_path(:event_id => @ride.event.slug, :id => @ride.auth)
      )
    end
  end
  
  describe "with invalid params" do
    before do
      post :create, :event_id => @ride.event.id, :id => @ride.auth,
                    :email => 'bogus'
    end
    
    it "should not set @current_ride" do
      controller.send(:current_ride).should be_nil
    end
    
    it "should render :new" do
      response.should render_template('new')
    end
  end
end