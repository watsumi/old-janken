class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :require_login
  helper_method :secret_clearance

  def secret_clearance
    session[:clearance].presence || false
  end

  def require_login
    redirect_to root_path unless current_user
  end
end
