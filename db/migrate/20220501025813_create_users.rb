class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :nickname, null: false, default: ""
      t.string :user_token_digest, null: false, default: ""
      t.integer :character_id, null: false, default: 1

      t.timestamps
    end
  end
end
