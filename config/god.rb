require 'yaml'

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
yaml = File.join(RAILS_ROOT, %w(config backgroundrb.yml))
config = YAML::load(File.read(yaml))

God.watch do |w|
  w.name = 'backgroundrb'
  w.uid = 'josh'
  w.gid = 'josh'
  w.interval = 1.minute
  w.grace = 1.minute
  w.start = "#{RAILS_ROOT}/script/backgroundrb -e production start"
  w.stop  = "#{RAILS_ROOT}/script/backgroundrb stop"
  w.behavior :clean_pid_file
  w.pid_file = File.join(RAILS_ROOT, "shared/pids/backgroundrb_#{config[:backgroundrb][:port]}.pid")
  
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
      c.notify = 'josh'
    end
  end
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 100.megabytes
      c.times = [3,5]
      c.notify = 'josh'
    end
  end
end