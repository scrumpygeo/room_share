class Room < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :guest_nr, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000 }

  after_validation :geocode



  geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  # def available?(from, to)
	# 	booking.where('start_date <= ? AND end_date >= ?', to, from).none?
	# end

  def address
    [street, city].compact.join(", ")
  end

end
