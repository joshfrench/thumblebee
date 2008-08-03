class RideMailer < ActionMailer::Base
  def new_ride(ride)
    @recipients     = "#{ride.email}"
    @from           = "#{ride.event.contact} <#{ride.event.email}>"
    @subject        = "Thanks for posting to the ride board"
    @sent_on        = Time.now
    @body[:ride]    = ride
    @body[:event]   = ride.event
  end
end
