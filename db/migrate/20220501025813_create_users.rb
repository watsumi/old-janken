class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false, default: ""
      t.string :uuid_digest, null: false, default: ""
      t.integer :character_id, null: false, default: 1

      t.timestamps
    end
  end
end
