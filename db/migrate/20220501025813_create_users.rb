class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :user_token_digest, null: false, default: ""
      t.integer :role, null: false
      t.string :game_id, null: false
      t.integer :character_id, null: false, default: 1

      t.timestamps
      t.index [:game_id, :role], unique: true
    end
  end
end
