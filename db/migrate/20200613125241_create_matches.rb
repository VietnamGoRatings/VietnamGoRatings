class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :white, foreign_key: {to_table: :players}
      t.references :black, foreign_key: {to_table: :players}
      t.string :event, null: false
      t.string :round
      t.string :result

      t.integer :handicap, default: 0
      t.decimal :komi, null: false, precision: 2, scale: 1
      t.date :date

      t.timestamps
    end
  end
end
