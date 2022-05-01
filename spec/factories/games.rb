# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#  guest_id   :integer
#  users_id   :bigint           not null
#
# Indexes
#
#  index_games_on_users_id  (users_id)
#  index_games_on_uuid      (uuid)
#
# Foreign Keys
#
#  fk_rails_...  (users_id => users.id)
#
FactoryBot.define do
  factory :game do
    uuid { "MyString" }
    host_id { 1 }
    guest_id { 1 }
    field_id { 1 }
  end
end
