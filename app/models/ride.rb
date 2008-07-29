class Ride < ActiveRecord::Base
  
  belongs_to  :event
  
  validates_presence_of       :driver, :message => "You left your name blank."
  validates_format_of         :email, 
                              :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                              :message => 'Please enter a valid email address.'
  validates_presence_of       :location, :message => "You left your departure location blank."
  validates_numericality_of   :seats, :with => /\d/
  attr_protected              :event_id
  
  def before_create
    make_auth
    make_anonymail
  end
  
  def min_seats
    self.new_record? ? 1 : 0
  end
  
  private
    def make_auth
      auth_list = Ride.find(:all, :select => :auth).map { |x| x.auth }
      self.auth ||= random8
      while auth_list.include? self.auth do
        self.auth.succ!
      end
      true
    end
  
    def make_anonymail
      email_list = Ride.find(:all, :select => :anonymail).map { |x| x.anonymail }
      self.anonymail ||= random8
      while email_list.include? self.anonymail do
        self.anonymail.succ!
      end
      true
    end
    
    def random8
      Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )[0..8].upcase
    end
end
