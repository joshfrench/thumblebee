class MailmanWorker < BackgrounDRb::MetaWorker
  set_worker_name :mailman_worker
  def create(args = nil)
    @mailbox_path = '/var/mail/thumblebee'
  end
  
  def check_queue
    mailbox = TMail::UNIXMbox.new(@mailbox_path)
    mailbox.each_port { |mail| Remailer.receive TMail::Mail.new(mail).to_s }
  end
end

