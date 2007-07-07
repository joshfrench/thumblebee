require File.dirname(__FILE__) + '/../test_helper'
require 'rides_controller'

# Re-raise errors caught by the controller.
class RidesController; def rescue_action(e) raise e end; end

class RidesControllerTest < Test::Unit::TestCase
  fixtures :rides, :events

  def setup
    @controller = RidesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create
    @event = events(:one)
    assert_difference @event.rides, :count do
      post :create, { :event_id => events(:one).slug, 
                      :ride => { :driver => "Joe Driver", 
                                :email => 'joe@vitamin-j.com', 
                                :location => "Brooklyn",
                                :seats => 3 } }    
    end
            
    assert_redirected_to event_path(@event)
  end
  
  def test_bad_create
    @event = events(:one)
    assert_no_difference @event.rides, :size do
      post :create, { :event_id => 'sampleevent', 
                      :ride => { :driver => "Joe Driver",  
                                :location => "Brooklyn",
                                :seats => "3" } }
    end
    assert_response :success
    assert_template "events/show"
  end
  
  def test_show
    get :show, { :event_id => rides(:one).event.slug, :id => rides(:one).auth }
    assert_equal rides(:one), assigns["ride"]
  end
  
  def test_update
    @ride = rides(:one)
    put :update, { :event_id => @ride.event.slug, :id => @ride.auth,
                   :ride => { :driver => 'New Name', 
                              :email => 'newemail@vitamin-j.com', :seats => 1,
                              :location => "Brooklyn" } }
    assert_equal 'New Name', @ride.reload.driver
  end
  
end
