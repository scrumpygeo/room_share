class ChangeDescriptionTypeInRooms < ActiveRecord::Migration[6.0]
  def change
    change_column :rooms, :description, :text
  end
end
