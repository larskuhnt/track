class ApplicationController < Track::Controller
  
  before_filter :set_application_param
  
  protected
  
  def set_application_param
    params[:app] = 'test_app'
  end
  
end