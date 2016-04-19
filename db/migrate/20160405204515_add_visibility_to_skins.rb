class AddVisibilityToSkins < ActiveRecord::Migration
  def change
    add_column :skins, :visibility, :integer
  end
end
