class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include BootstrapFlashHelper
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
     raise ActionController::RecordNotFound.new('Not Found')
     render :text => 'Not Found', :status => '404'
  end
  
  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
