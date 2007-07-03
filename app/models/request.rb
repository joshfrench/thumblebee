class Request < ActiveRecord::Base
  belongs_to  :ride
  
  validates_presence_of     :name
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_numericality_of :seats
end
