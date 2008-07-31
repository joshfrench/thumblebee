class Event < ActiveRecord::Base
  
  has_many :rides, :dependent => :destroy, :order => :location

  validates_presence_of   :name
  validates_presence_of   :slug
  validates_presence_of   :starts_on
  validates_inclusion_of  :starts_on, :in => (Date.today..(Date.today + 365)),
                          :message => "Your must specify a start time between now and #{Date.today.to_s :nice}"
  validates_presence_of   :contact
  validates_presence_of   :location
  validates_format_of     :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  def available_rides
    rides.reject { |ride| ride.seats < 1 }
  end
  
  def to_param
    slug
  end
  
  def self.delete_expires
    destroy_all "starts_on < '#{Date.today}'"
  end
  
end
