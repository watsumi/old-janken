class CreateGames < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :games, id: :uuid do |t|
      t.string :uuid, null: false
      t.integer :guest_id
      t.integer :field_id, null: false, default: 1
      t.references :users, null: false, foreign_key: true

      t.timestamps
      t.index :uuid
    end
  end
end
