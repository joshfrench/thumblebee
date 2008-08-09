Capistrano::Configuration.instance.load do
  namespace :backgroundrb do
    desc "Start the backgroundrb server"
    task :start do
      sudo "god start backgroundrb"
      logger.info 'Waiting for backgroundrb to start...'
      bdrb = thumblebee.get_backgroundrb_config
      sleep 10 while capture("find #{shared_path}/pids -name backgroundrb_#{bdrb[:port]}.pid").empty?
    end
    after 'deploy:restart', 'backgroundrb:start'

    desc "Stop the backgroundrb server"
    task :stop do
      sudo "god stop backgroundrb"
      logger.info 'Waiting for backgroundrb to stop...'
      bdrb = thumblebee.get_backgroundrb_config
      sleep 10 while capture("find #{shared_path}/pids -name backgroundrb_#{bdrb[:port]}.pid").any?
    end
    before 'deploy', 'backgroundrb:stop'
  end
end