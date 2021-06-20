class AddTournamentIdToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :tournament_id, :integer, null: true
    add_foreign_key :matches, :tournaments
  end
end
