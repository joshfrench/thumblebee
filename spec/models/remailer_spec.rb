require File.dirname(__FILE__) + '/../spec_helper'

describe Remailer do
  fixtures :all
  
  before do
    ActionMailer::Base.delivery_method = :test 
    ActionMailer::Base.perform_deliveries = true 
    ActionMailer::Base.deliveries = []
    @ride  = rides(:available)
    @event = events(:active)
    @mail  = File.read(File.join(File.dirname(__FILE__), %w(.. fixtures email.txt)))
  end
  
  describe "with a valid email address" do
    before do
      Ride.stub!(:find_by_anonymail).with(['123456@thumblebee.com']).and_return(@ride)
    end
    
    after do
      Remailer.receive(@mail)
    end
    
    it "should find a ride" do
      Ride.should_receive(:find_by_anonymail).with(['123456@thumblebee.com']).and_return(@ride)
    end
    
    it "should forward to final recipient" do
      Remailer.should_receive(:deliver_forward) do |ride,mail|
        ride.should eql(@ride)
        mail.should be_kind_of(TMail::Mail)
      end
    end
  end
  
  describe "with a bogus address" do
    it "should not forward" do
      Ride.should_receive(:find_by_anonymail).with(['123456@thumblebee.com']).and_return(nil)
      Remailer.should_not_receive(:deliver_forward)
      Remailer.receive(@mail)
    end
  end
  
  describe "#forward" do
    before do
      Ride.stub!(:find_by_anonymail).with(['123456@thumblebee.com']).and_return(@ride)
      @email = Remailer.create_forward(@ride, TMail::Mail.parse(@mail))
    end
    
    it "should use original subject" do
      @email.subject.should eql('SAMPLE EMAIL')
    end
    
    it "should forward to driver" do
      @email.to.should eql([@ride.email])
    end
    
    it "should be from original sender" do
      @email.from.should eql(['josh@vitamin-j.com'])
    end
    
    it "should reply-to original sender" do
      @email.reply_to.should eql(['josh@vitamin-j.com'])
    end
    
    it "should retain body" do
      @email.body.should match(/in Unix MBox format/)
    end
    
    it "should announce remailing" do
      @email.body.should match(/123456@thumblebee.com/)
    end
  end
end