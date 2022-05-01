class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index; end
  def welcome; end

  private

  def authenticate_user!
    return if current_user

    redirect_to root_path
  end
end
