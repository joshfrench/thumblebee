Capistrano::Configuration.instance.load do
  namespace :backgroundrb do
    desc "Start the backgroundrb server"
    task :start do
      sudo "god start backgroundrb"
    end
    
    desc "Stop the backgroundrb server"
    task :stop do
      sudo "god stop backgroundrb"
    end
  end
end