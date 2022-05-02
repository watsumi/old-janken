class CreateGameDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :game_details do |t|
      t.string :user_id, null: false, default: 0
      t.string :game_id, null: false, default: 0
      t.integer :request_id, null: false, default: 0
      t.integer :hand_id, null: false, default: 0
      t.integer :support_id, null: false, default: 0
      t.integer :round_score, null: false, default: 0

      t.timestamps
      t.index [:user_id, :game_id]
    end
  end
end
