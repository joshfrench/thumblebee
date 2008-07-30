module Authentication
  protected
    def logged_in?
      !current_ride.blank?
    end
    
    def current_ride
      @current_ride ||= (session[:ride] && Ride.find_by_auth(session[:ride]))
    end
    
    def current_ride=(new_ride)
      session[:ride] = new_ride.blank? ? nil : new_ride.auth
      @current_ride = new_ride
    end

    def login_required
      logged_in? && authorized? || access_denied
    end

    def access_denied
      flash[:errors] = true
      redirect_to new_session_path(:event_id => params[:event_id], :id => params[:id])
      false
    end  
    
    def self.included(base)
      base.send :helper_method, :current_user, :logged_in?
    end
end
