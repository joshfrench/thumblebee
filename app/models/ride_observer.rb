class RideObserver < ActiveRecord::Observer
  def after_create(ride)
    RideMailer.deliver_new_ride(ride)
  end
end
