class AddDisplayNameToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :display_name, :string, null: false
  end
end
