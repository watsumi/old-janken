# == Schema Information
#
# Table name: users
#
#  id           :uuid             not null, primary key
#  nickname     :string           default(""), not null
#  uuid_digest  :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :integer          default(1), not null
#
class User < ApplicationRecord
end
