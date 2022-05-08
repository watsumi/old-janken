class CreateUserHands < ActiveRecord::Migration[7.0]
  def change
    create_table :user_hands, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :hand

      t.timestamps
    end
  end
end
