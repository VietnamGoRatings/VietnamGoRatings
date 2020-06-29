class AddRatingToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :rating, :integer
  end
end
