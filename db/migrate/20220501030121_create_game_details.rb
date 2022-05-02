class CreateGameDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :game_details, id: :uuid do |t|
      t.string :user_id, null: false
      t.string :game_id, null: false
      t.integer :request_id, null: false
      t.integer :attacker_role, null: false
      t.integer :hand, null: false
      t.integer :support_id, null: false
      t.integer :round_score, null: false

      t.timestamps
      t.index [:user_id, :game_id]
    end
  end
end
