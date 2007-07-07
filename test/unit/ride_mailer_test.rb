require File.dirname(__FILE__) + '/../test_helper'

class RideMailerTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  fixtures :rides, :events

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
    @expected.mime_version = '1.0'
  end
  
  def test_new_ride
    @ride = rides(:one)
    
    response = RideMailer.create_new_ride(@ride)
    assert_match /Josh French/, response.body
    assert_match /Joey Contact/, response.body
    assert_match /vitamin-j.com\/rideboard\/sampleevent\/rides/, response.body
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/ride_mailer/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
