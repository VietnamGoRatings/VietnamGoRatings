class AddGenderPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :is_male, :integer, null: false, default: 1
  end
end
