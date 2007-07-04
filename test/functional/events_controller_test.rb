require File.dirname(__FILE__) + '/../test_helper'
require 'events_controller'

# Re-raise errors caught by the controller.
class EventsController; def rescue_action(e) raise e end; end

class EventsControllerTest < Test::Unit::TestCase
  fixtures :events

  def setup
    @controller = EventsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_create
    post :create, :event => { :name => 'This is Just a Sample Event',
                              :slug => 'sampleevent',
                              :location => 'Ithaca, NY',
                              :starts_on => 1.week.from_now.to_s,
                              :contact => 'Josh French',
                              :email => 'josh@vitamin-j.com' }
    assert_redirected_to event_path(Event.find_by_slug('sampleevent'))
  end
  
  def test_show
    @event = Event.new
    Event.expects(:find_by_slug).with('sample').returns(@event)
    get :show, :id => 'sample'
    assert_response :success
    assert_equal @event, assigns["event"]
  end
  
  def test_new
    get :new
    assert assigns["event"].new_record?
    assert_equal Date.new.to_s, assigns["event"].starts_on.to_s
  end
end
