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
    
    expire_fragment event_cache_key(event)
  end
  
end