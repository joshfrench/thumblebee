RAILS_ROOT = '/var/www/thumblebee.com/current'

God::Contacts::Email.message_settings = {
  :from => 'god@thumblebee.com'
}

God::Contacts::Email.server_settings = {
  :address        => "localhost",
  :port           => 25
}

God.contact(:email) do |c|
  c.name  = 'josh'
  c.email = 'josh@vitamin-j.com'
end

################
# BACKGROUNDRB #
################
God.watch do |w|
  w.name = 'backgroundrb'
  w.interval = 1.minute
  w.grace = 1.minute
  w.start = "#{RAILS_ROOT}/script/backgroundrb -e production start"
  w.stop  = "#{RAILS_ROOT}/script/backgroundrb -e production stop"
  w.behavior :clean_pid_file
  w.pid_file = File.join(RAILS_ROOT, 'tmp/backgroundrb_11006.pid')
  
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
      c.notify = 'josh'
    end
  end
  
  w.restart_if do |start|
    restart_condition(:memory_usage) do |c|
      c.above = 50.megabytes
      c.times = [3,5]
      c.notify = 'josh'
    end
  end
end