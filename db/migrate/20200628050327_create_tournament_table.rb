class CreateTournamentTable < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.integer :start_date
      t.integer :end_date
    end
  end
end
