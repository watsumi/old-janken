class HomeController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def index; end
  def welcome; end
end
