class Room < ApplicationRecord
  belongs_to :user
  has_many :bookings

  # def available?(from, to)
	# 	booking.where('start_date <= ? AND end_date >= ?', to, from).none?
	# end


end
