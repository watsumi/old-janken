# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#  guest_id   :integer
#  user_id    :uuid             not null
#
# Indexes
#
#  index_games_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Game, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
