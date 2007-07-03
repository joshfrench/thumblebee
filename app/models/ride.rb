class Ride < ActiveRecord::Base
  belongs_to  :event
  belongs_to  :driver, :class_name => :person, :foreign_key => :driver_id 
  
  def before_create
    self.auth = Time.now.to_s.split(//).sort_by{ rand }.reject{ |c| c =~ /\W/ }.join.upcase
  end
end
