class Ride < ActiveRecord::Base
  
  belongs_to  :event
  has_many    :requests
  
  validates_presence_of       :driver
  validates_format_of         :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_presence_of       :location
  validates_presence_of       :leave_at
  validates_presence_of       :return_at
  validates_numericality_of   :seats, :with => /\d/
  
  def before_create
    self.auth = Time.now.to_s.split(//).reject{ |c| c =~ /\W/ }.sort_by{ rand }.join.upcase
  end
end
