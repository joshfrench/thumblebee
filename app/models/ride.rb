class Ride < ActiveRecord::Base
  
  belongs_to  :event
  
  validates_presence_of       :driver, :message => "You left your name blank."
  validates_format_of         :email, 
                              :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                              :message => 'That\'s not a valid email.',
                              :allow_nil => true,
                              :if => Proc.new { |r| r.phone.nil? || r.phone.empty? }
  validates_presence_of       :email, 
                              :message => "Please enter a phone number or email address.",
                              :if => Proc.new { |r| r.phone.nil? || r.phone.empty? }
  validates_presence_of       :phone,
                              :message => "Please enter a phone number or email address.",
                              :if => Proc.new { |r| r.email.nil? || r.email.empty? }
  validates_presence_of       :location, :message => "You left your departure location blank."
  validates_numericality_of   :seats, :with => /\d/
  attr_protected              :event_id
  
  def before_create
    self.auth = Time.now.to_s.split(//).reject{ |c| c =~ /\W/ }.sort_by{ rand }.join.upcase
  end
  
  def min_seats
    self.new_record? ? 1 : 0
  end
end
