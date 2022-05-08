class HomeController < ApplicationController
  skip_before_action :require_login, only: %i[ welcome index ]

  def index; end
  def welcome; end
end
