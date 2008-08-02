Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :db do
      
      desc "Make shared DB file"
      task :touch_production do
        config = thumblebee.get_db_config
        run "mkdir -p #{shared_path}/db"
        run "touch #{shared_path}/#{config[:database]}"
      end
      after 'deploy:setup', 'deploy:db:touch_production'
      
      desc "Symlink production DB to shared location"
      task :symlink do
        config = thumblebee.get_db_config
        run "ln -sf #{current_path}/#{config[:database]} #{shared_path}/#{config[:database]}"
      end
      after 'deploy:symlink', 'deploy:db:symlink'
      
    end
  end
end