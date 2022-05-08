class StaticController < ApplicationController

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
