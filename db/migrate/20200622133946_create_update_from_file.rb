class CreateUpdateFromFile < ActiveRecord::Migration[6.0]
  def change
    create_table :update_from_files do |t|
      t.string :type
      t.string :data, null: false
      t.timestamps
    end
  end
end
