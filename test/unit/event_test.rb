require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :events

  def test_should_create
    assert_difference Event, :count do
      create_event
    end
  end

  def test_should_require_name
    assert !(create_event :name => nil).valid?
  end
  
  def test_should_require_slug
    assert !(create_event :slug => nil).valid?
  end
  
  def test_should_require_starting_date
    assert !(create_event :starts_on => nil).valid?
  end
  
  def test_should_require_contact
    assert !(create_event :contact => nil).valid?
  end
  
  def test_should_require_valid_email
    assert !(create_event :email => nil).valid?
    assert !(create_event :email => 'josh at vitamin-j.com').valid?
    assert !(create_event :email => 'josh@vitamin-j').valid?
  end
  
  def test_should_require_location
    assert !(create_event :location => nil).valid?
  end
  
  def test_should_use_slug_as_param
    slug = 'thisisasampleslug'
    @event = Event.new
    @event.slug = slug
    assert_equal @event.to_param, slug
  end
  
  def test_available_rides
    @full_ride = Ride.new(:seats => 0)
    @available_ride = Ride.new(:seats => 2)
    @event = Event.new
    @event.expects(:rides).returns([@full_ride, @available_ride])
    assert @event.available_rides.include?(@available_ride)
  end
  
  private
  def create_event(options={})
    Event.create({:name => "Sample Event", :slug => "samplevent",
                  :starts_on => (1.week.from_now.to_s :db),
                  :contact => 'Joey Sample', :email => 'jsample@vitamin-j.com',
                  :location => 'Ithaca, NY' }.merge options)
                
  end
end
