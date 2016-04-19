class AddUserIdToSkins < ActiveRecord::Migration
  def change
    add_column :skins, :user_id, :integer
  end
end
