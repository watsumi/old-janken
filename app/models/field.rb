class Field < ActiveYamlRecord
  fields :id, :title, :description, :card_image

  has_many :games, dependent: :nullify, inverse_of: :field
end
