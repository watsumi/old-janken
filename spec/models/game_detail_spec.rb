# == Schema Information
#
# Table name: game_details
#
#  id          :bigint           not null, primary key
#  round_score :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :string           default("0"), not null
#  hand_id     :integer          default(0), not null
#  request_id  :integer          default(0), not null
#  support_id  :integer          default(0), not null
#  user_id     :string           default("0"), not null
#
# Indexes
#
#  index_game_details_on_user_id_and_game_id  (user_id,game_id)
#
require 'rails_helper'

RSpec.describe GameDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
