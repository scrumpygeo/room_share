class AddInfoToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :price, :decimal
    add_column :rooms, :address, :string
    add_column :rooms, :city, :string
    add_column :rooms, :guest_nr, :integer
    add_column :rooms, :photo, :string
  end
end