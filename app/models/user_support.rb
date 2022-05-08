class UserSupport < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to_active_hash :support

  validates :support_id, uniqueness: { scope: :user_id }

  after_destroy_commit do
    broadcast_remove_to self
  end
end
