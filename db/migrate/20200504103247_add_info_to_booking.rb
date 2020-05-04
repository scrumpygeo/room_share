class AddInfoToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :price, :decimal
    add_column :bookings, :guest_nr, :integer
  end
end
