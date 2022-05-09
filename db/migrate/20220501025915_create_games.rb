class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games, id: :uuid do |t|
      t.integer :field_id, null: false, default: 1
      t.string :winner
      
      t.timestamps
    end
  end
end
