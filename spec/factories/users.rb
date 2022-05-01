# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  nickname     :string           default(""), not null
#  uuid_digest  :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :integer          default(1), not null
#
FactoryBot.define do
  factory :user do
    nickname { "MyString" }
    status { 1 }
    uuid_digest { "MyString" }
    character_id { 1 }
  end
end
