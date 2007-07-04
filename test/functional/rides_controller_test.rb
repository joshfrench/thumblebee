require File.dirname(__FILE__) + '/../test_helper'
require 'rides_controller'

# Re-raise errors caught by the controller.
class RidesController; def rescue_action(e) raise e end; end

class RidesControllerTest < Test::Unit::TestCase
  fixtures :rides

  def setup
    @controller = RidesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create
    @event = Event.new(:name => 'Sample Event', :slug => 'sampleevent')
    Event.expects(:find_by_slug).with('sampleevent').returns(@event)

    post :create, { :event_id => 'sampleevent', 
                    :ride => { :driver => "Joe Driver", 
                                :email => 'joe@vitamin-j.com', 
                                :location => "Brooklyn",
                                :leave_at => "July 26, noon",
                                :return_at => "July 28, noon",
                                :seats => "3" } }                     
    assert_redirected_to event_path(@event)
  end
end
