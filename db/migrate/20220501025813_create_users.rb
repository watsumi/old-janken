class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :users, id: :uuid do |t|
      t.string :user_token_digest
      t.integer :role, null: false
      t.string :game_id, null: false
      t.integer :character_id, null: false

      t.timestamps
      t.index [:game_id, :role], unique: true
    end
  end
end
