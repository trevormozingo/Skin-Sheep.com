class AddDescriptionToSkins < ActiveRecord::Migration
  def change
    add_column :skins, :description, :text
  end
end
