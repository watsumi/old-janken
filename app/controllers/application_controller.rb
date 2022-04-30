class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_user

  private

  def set_user
    return if current_user

    user = User.create_anonymously!
    remember(user)
  end
end
