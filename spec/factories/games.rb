# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  board_json :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#
FactoryBot.define do
  factory :game do
    uuid { 'MyString' }
    host_id { 1 }
    guest_id { 1 }
    field_id { 1 }
  end
end
