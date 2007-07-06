class Ride < ActiveRecord::Base
  
  belongs_to  :event
  has_many    :requests
  
  validates_presence_of       :driver
  validates_format_of         :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_presence_of       :location
  validates_numericality_of   :seats, :with => /\d/
  attr_protected              :event_id
  
  def before_create
    self.auth = Time.now.to_s.split(//).reject{ |c| c =~ /\W/ }.sort_by{ rand }.join.upcase
  end
  
  def min_seats
    self.new_record? ? 1 : 0
  end
end
