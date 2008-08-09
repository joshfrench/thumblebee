Capistrano::Configuration.instance.load do
  namespace :backgroundrb do
    desc "Start the backgroundrb server"
    task :start do
      sudo "god start backgroundrb"
      logger.info 'Waiting for backgroundrb to start...'
      sleep 10 while capture("find #{shared_path}/pids -name backgroundrb_11006.pid").empty?
    end
    after 'deploy:restart', 'backgroundrb:start'
    
    desc "Stop the backgroundrb server"
    task :stop do
      sudo "god stop backgroundrb"
      logger.info 'Waiting for backgroundrb to stop...'
      sleep 10 while capture("find #{shared_path}/pids -name backgroundrb_11006.pid").any?
    end
    before 'deploy', 'backgroundrb:stop'
  end
end