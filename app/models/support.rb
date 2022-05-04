class Support < ActiveYamlRecord
  fields :id, :title, :description, :card_image

  has_many :users, dependent: :nullify, inverse_of: :support
end
