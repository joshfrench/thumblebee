require File.dirname(__FILE__) + '/../test_helper'

class RequestTest < Test::Unit::TestCase
  fixtures :requests

  def test_should_create
    assert_difference Request, :count do
      create_request
    end
  end
  
  def test_should_require_name
    assert !(create_request :name => nil).valid?
  end
  
  def test_should_require_email
    assert !(create_request :email => nil).valid?
    assert !(create_request :email => 'joey@').valid?
  end
  
  def test_should_require_seats
    assert !(create_request :seats => nil).valid?
  end
  
  private
  def create_request(options={})
    Request.create({:name => "Joey Request", :email => 'request@vitamin-j.com',
                    :seats => 1}.merge options )
  end
end
