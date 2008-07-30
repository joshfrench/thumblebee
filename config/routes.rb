ActionController::Routing::Routes.draw do |map|

  map.resources :events do |event|
    event.resources :rides, :path_prefix => ':event_id', :name_prefix => ''
  end
  
  map.with_options :controller => 'sessions' do |session|
    session.new_session ':event_id/rides/:id/login', :action => 'new', :conditions => { :method => :get }
    session.session ':event_id/rides/:id/login', :action => 'create', :conditions => { :method => :post }
  end
  
  map.default ':id', :controller => 'events', :action => 'show'

end
