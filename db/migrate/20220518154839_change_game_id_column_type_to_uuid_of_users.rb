class ChangeGameIdColumnTypeToUuidOfUsers < ActiveRecord::Migration[7.0]
  def change
    change_table(:users) do |t|
      t.remove :game_id
      t.belongs_to :game, type: :uuid, foreign_key: true
    end
  end
end
