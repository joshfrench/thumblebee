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
    self.auth = Time.now.to_s.split(//).reject{ |c| c =~ /\W/ }.sort_by{ rand }.join.upcase
  end
  
  def min_seats
    self.new_record? ? 1 : 0
  end
end
