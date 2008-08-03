Capistrano::Configuration.instance.load do
  namespace :backgroundrb do
    desc "Start the backgroundrb server"
    task :start do
      sudo "god start backgroundrb"
    end
    # after 'deploy:restart', 'backgroundrb:start'
    
    desc "Stop the backgroundrb server"
    task :stop do
      sudo "god stop backgroundrb"
      logger.info "Pause while backgroundrb goes down"
      60.times { print '.' ; sleep 1 }
      puts
    end
    # before 'deploy', 'backgroundrb:stop'
  end
end