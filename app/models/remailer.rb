class Remailer < ActionMailer::Base
  def forward(ride,email)
    @recipients      = ride.email
    @from            = email.from.first
    @reply_to        = email.from.first
    @subject         = email.subject
    @body[:message]  = email.body
    @body[:orig_to]  = email.to.first
    @body[:event]    = ride.event
  end

  def receive(mail)
    mail.to.first.scan /^(.*)@/ do |addr|
      if ride = Ride.find_by_anonymail(addr)
        self.class.deliver_forward(ride, mail)
      end
    end
  end
end
