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

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
