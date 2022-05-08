class Support < ActiveYamlRecord
  fields :id, :title, :description, :card_image

  has_many :game_details, dependent: :nullify, inverse_of: :support
  has_many :user_supports, dependent: :nullify, inverse_of: :support
end
