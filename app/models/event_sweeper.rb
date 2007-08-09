class EventSweeper < ActionController::Caching::Sweeper

  observe Ride, Event
  
  def after_save(record)
    expire_record(record)
  end
  
  def after_destroy(record)
    expire_record(record)
  end
  
  def expire_record(record)
    event = nil
    case record
    when Event
      event = record
    when Ride
      event = record.event
    end
    
    FileUtils.rm_rf File.expand_path("public/events/#{event.slug}.html", RAILS_ROOT)
    FileUtils.rm_rf File.expand_path("public/#{event.slug}.html", RAILS_ROOT)
  end
  
end