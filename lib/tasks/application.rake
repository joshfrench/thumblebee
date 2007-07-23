desc "Delete expired events"
task :delete_expired_events => [:environment] do
  Event.delete_expires
end

desc "Remove dead sessions"
task :prune_sessions => [:environment] do
  ActiveRecord::Base.connection.execute 'DELETE FROM sessions WHERE updated_at < ADDDATE(NOW(), INTERVAL -1 DAY)'
end

desc "Trim log files"
task :trim_logs => [:environment] do
  log_dir = "#{RAILS_ROOT}/log"
  trim_logs = ['production.log', 'mongrel.log']
  trim_logs.each do |logfile|
    %x{ tail -10000 #{log_dir}/#{logfile} > #{log_dir}/tmp.log; mv -f #{log_dir}/tmp.log #{log_dir}/#{logfile} }
  end
end