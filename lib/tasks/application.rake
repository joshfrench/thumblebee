desc "Delete expired events"
task :delete_expired_events => [:environment] do
  Event.delete_expires
end