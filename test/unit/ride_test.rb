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
  
  def test_should_require_email_or_phone
    assert !(create_ride :email => nil).valid?
    assert (create_ride :email => nil, :phone => '123 456 7890').valid?
    assert !(create_ride :email => 'josh@').valid?
    assert !(create_ride :email => 'josh at vitamin-j.com').valid?
  end
  
  def test_should_require_location
    assert !(create_ride :location => nil).valid?
  end
  
  def test_should_require_seats
    assert !(create_ride :seats => nil).valid?
  end
  
  def test_min_seats
    assert_equal 1, Ride.new.min_seats
    assert_equal 0, rides(:one).min_seats
  end
  
  private
  def create_ride(options={})
    events(:one).rides.create({:driver => 'Joey Driver', :email => 'driver@vitamin-j.com',
                 :location => "Brooklyn", :seats => 4 }.merge options )
  end
end
