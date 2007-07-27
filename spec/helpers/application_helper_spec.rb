require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do
  
  fixtures :events
  
  it "should find an existing event image" do
    @event = mock_model(Event)
    @event.stub!(:slug).and_return('demo')
    event_image(@event).should match(/demo.gif/)
  end
  
  it "should skip a non-extant event image" do
    @event = mock_model(Event)
    @event.stub!(:slug).and_return('foo')
    event_image(@event).should be_nil
  end
  
  it "should not show hint for a new ride" do
    @ride = mock_model(Ride)
    @ride.stub!(:new_record?).and_return true
    seat_hint_for(@ride).should_not match(/class="hint"/)
    seat_hint_for(@ride).should_not match(/<p>/)
  end
  
  it "should show hint for existing ride" do
    @ride = mock_model(Ride)
    @ride.stub!(:new_record?).and_return false
    seat_hint_for(@ride).should match(/class="hint"/)
  end
  
  it "should show errors_on an invalid object" do
    @object = mock('mocky')
    @errors = { :takeout => "I ordered General Tso's chicken; this is Kung Pao." }
    @object.stub!(:errors).and_return(@errors)
    @errors.stub!(:count).and_return(1) # count is an AR::Errors method, not a hash method
    errors_on(:object).should match(/oops/i)
    errors_on(:object).should match(/<ul>/)
  end
  
  it "should do nothing with no errors_on" do
    @object = mock("object")
    @errors = mock("errors")
    @errors.should_receive(:count).and_return(0)
    @object.should_receive(:errors).and_return(@errors)
    errors_on(:object).should be_nil
  end
end
