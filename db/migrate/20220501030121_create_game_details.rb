class CreateGameDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :game_details do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :game, type: :uuid, foreign_key: true
      t.integer :turn, null: false
      t.integer :hand_id
      t.integer :support_id
      t.integer :round_score

      t.timestamps
    end
  end
end
