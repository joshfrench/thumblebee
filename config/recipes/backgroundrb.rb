Capistrano::Configuration.instance.load do
  namespace :backgroundrb do
    desc "Start the backgroundrb server"
    task :start do
      run "cd #{current_path} && ./script/backgroundrb start"
    end
    
    desc "Stop the backgroundrb server"
    task :stop do
      run "cd #{current_path} && ./script/backgroundrb stop"
    end
  end
end