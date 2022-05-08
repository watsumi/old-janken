class CreateUserSupports < ActiveRecord::Migration[7.0]
  def change
    create_table :user_supports, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :support

      t.timestamps
    end
  end
end
