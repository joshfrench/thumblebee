require File.dirname(__FILE__) + '/../test_helper'

class RideTest < Test::Unit::TestCase
  fixtures :rides, :events

  def test_should_create
    assert_difference Ride, :count do
      @ride = create_ride
    end
    assert_not_nil @ride.auth
  end
  
  def test_should_require_driver
    assert !(create_ride :driver => nil).valid?
  end
  
  def test_should_require_email
    assert !(create_ride :email => nil).valid?
    assert !(create_ride :email => 'josh@').valid?
    assert !(create_ride :email => 'josh at vitamin-j.com').valid?
  end
  
  def test_should_require_location
    assert !(create_ride :location => nil).valid?
  end
  
  def test_should_require_leave_at
    assert !(create_ride :leave_at => nil).valid?
  end
  
  def test_should_require_return_at
    assert !(create_ride :return_at => nil).valid?
  end
  
  def test_should_require_seats
    assert !(create_ride :seats => nil).valid?
  end
  
  private
  def create_ride(options={})
    events(:one).rides.create({:driver => 'Joey Driver', :email => 'driver@vitamin-j.com',
                 :location => "Brooklyn", :leave_at => "Saturday around noon",
                 :return_at => "Sunday evening", :seats => 4 }.merge options )
  end
end
