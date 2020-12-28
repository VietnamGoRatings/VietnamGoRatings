class AllowClubToBeNull < ActiveRecord::Migration[6.0]
  def up
    change_column :players, :club_id, :integer, null: true
    change_column :players, :birthyear, :integer, null: true
    change_column :players, :display_name, :string, null: true
  end

  def down
    change_column :players, :club_id, :integer, null: false
    change_column :players, :birthyear, :integer, null: false
    change_column :players, :display_name, :string, null: false
  end
end
