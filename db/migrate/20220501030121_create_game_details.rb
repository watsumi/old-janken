class CreateGameDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :game_details, id: :uuid do |t|
      t.references :game, type: :uuid, null: false, foreign_key: true
      t.integer :hand_1, null: false, default: 0
      t.integer :hand_2, null: false, default: 0
      t.integer :hand_3, null: false, default: 0
      t.integer :support_id, null: false, default: 0
      t.integer :round_score_1, null: false, default: 0
      t.integer :round_score_2, null: false, default: 0
      t.integer :round_score_3, null: false, default: 0

      t.timestamps
    end
  end
end
