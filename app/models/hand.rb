class Hand < ActiveYamlRecord
  fields :id, :title, :description, :card_image

  has_many :user_hands, dependent: :nullify, inverse_of: :hand
end
