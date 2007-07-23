desc "Delete expired events"
task :delete_expired_events => [:environment] do
  Event.delete_expires
end

desc "Remove old sessions"
task :remove_old_sessions => [:environment] do
  ActiveRecord::Base.connection.execute 'DELETE FROM sessions WHERE updated_at < ADDDATE(NOW(), INTERVAL -1 DAY)'
end