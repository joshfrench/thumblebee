require File.dirname(__FILE__) + '/../test_helper'

class RideObserverTest < Test::Unit::TestCase
  fixtures :rides, :events
  
  def setup
    ActionMailer::Base.deliveries = []
    @emails = ActionMailer::Base.deliveries
  end

  def test_create_ride
    assert_difference @emails, :size do
      events(:one).rides.create(:driver => 'Josh', :email => 'josh@vitamin-j.com', :location => "brooklyn", :event_id => 1,
                  :leave_at => 'now', :return_at => 'later', :seats => 3)
    end
  end
end
