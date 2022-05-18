class StaticController < ApplicationController
  skip_before_action :require_login

  def index; end

  def rules
    @characters = Character.all
    @supports = Support.all
    @hands = Hand.all
    @fields = Field.all
  end

  def turms; end
  def credits; end
  def privacy_policy; end
end
