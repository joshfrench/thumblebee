Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :db do
      
      desc "Make shared DB file"
      task :touch_production do
        config = thumblebee.get_db_config
        run "mkdir -p #{File.join shared_path, File.dirname(config[:database])}"
        run "touch #{File.join shared_path, config[:database]}"
      end
      after 'deploy:setup', 'deploy:db:touch_production'
      
      desc "Symlink production DB to shared location"
      task :symlink do
        config = thumblebee.get_db_config
        run "ln -sf #{File.join shared_path, config[:database]} #{File.join current_path, config[:database]}"
      end
      after 'deploy:symlink', 'deploy:db:symlink'
      
    end
    
    task :migrations do
      set :migrate_target, :current
      update_code
      symlink
      migrate
      restart
    end
  end
end