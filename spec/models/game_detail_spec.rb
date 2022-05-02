# == Schema Information
#
# Table name: game_details
#
#  id            :uuid             not null, primary key
#  attacker_role :integer          not null
#  hand          :integer          not null
#  round_score   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :string           not null
#  request_id    :integer          not null
#  support_id    :integer          not null
#  user_id       :string           not null
#
# Indexes
#
#  index_game_details_on_user_id_and_game_id  (user_id,game_id)
#
require 'rails_helper'

RSpec.describe GameDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
