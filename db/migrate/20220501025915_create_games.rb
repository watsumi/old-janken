class CreateGames < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :games, id: :uuid do |t|
      t.integer :field_id, null: false, default: 1
      t.text :board_json, null: false

      t.timestamps
    end
  end
end
