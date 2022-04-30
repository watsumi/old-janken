class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :field_id

      t.timestamps
    end
  end
end
