class CreateGameDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :game_details do |t|
      t.string :user_id, null: false
      t.string :game_id, null: false
      t.integer :turn, null: false
      t.integer :hand_id
      t.integer :support_id
      t.integer :round_score

      t.timestamps
    end
  end
end
