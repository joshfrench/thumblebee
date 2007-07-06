class Event < ActiveRecord::Base
  
  has_many :rides, :dependent => :destroy

  validates_presence_of   :name
  validates_presence_of   :slug
  validates_presence_of   :starts_on
  validates_presence_of   :contact
  validates_presence_of   :location
  validates_format_of     :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  def available_rides
    rides.reject { |ride| ride.seats < 1 }
  end
  
  def to_param
    "#{self.slug}"
  end
  
end
