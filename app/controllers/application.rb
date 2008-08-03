class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  include Authentication

  private
  
    def render_404
      respond_to do |type|
        type.html { render :template => "errors/404", :status => "404 Not Found"}
        type.all  { render :nothing => true, :status => "404 Not Found" }
      end
    end

    def render_500
      respond_to do |type|
        type.html { render :template => "errors/500", :status => "500 Error" }
        type.all  { render :nothing => true, :status => "500 Error" }
      end
    end

    def rescue_action_in_public(exception)
      case exception
        when *[ActiveRecord::RecordNotFound, ActionController::UnknownController,
               ActionController::UnknownAction, ActionController::RoutingError]
          render_404
        else          
          render_500
      end
    end
    
end
