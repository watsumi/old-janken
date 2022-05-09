# == Schema Information
#
# Table name: user_supports
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  support_id :bigint
#  user_id    :uuid
#
# Indexes
#
#  index_user_supports_on_support_id  (support_id)
#  index_user_supports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_support do
    support_id { 1 }
  end
end
