class Event < ActiveRecord::Base
  has_many  :rides
  has_one   :contact, :class_name => :person, :foreign_key => :contact_id
end
