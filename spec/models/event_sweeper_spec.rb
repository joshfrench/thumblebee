require File.dirname(__FILE__) + '/../spec_helper'

describe EventSweeper do
  fixtures :all
  
  before do
    @ride = rides(:available)
    @event = events(:active)
    @partial_path = File.expand_path("public/events/#{@event.slug}.html", RAILS_ROOT)
    @html_path = File.expand_path("public/#{@event.slug}.html", RAILS_ROOT)
  end
  
  it "should delete cache when an event is deleted" do
    FileUtils.should_receive(:rm_rf).with(@partial_path).at_least(:once)
    FileUtils.should_receive(:rm_rf).with(@html_path).at_least(:once)
    @event.destroy
  end
  
  it "should delete cache when an event is updated" do
    FileUtils.should_receive(:rm_rf).with(@partial_path).at_least(:once)
    FileUtils.should_receive(:rm_rf).with(@html_path).at_least(:once)
    @event.save
  end
  
  it "should delete cache when a ride is updated" do
    FileUtils.should_receive(:rm_rf).with(@partial_path).at_least(:once)
    FileUtils.should_receive(:rm_rf).with(@html_path).at_least(:once)
    @ride.save
  end
end