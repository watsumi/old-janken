class UserHands < ActiveRecord::Migration[7.0]
  def change
    create_table :user_hands do |t|
      t.string :user_id, null: false, foreign_key: true
      t.string :hand_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
