class AddBirthyearToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :birthyear, :integer, null: false
    add_index :players, [:name, :birthyear], :unique => true
  end
end
