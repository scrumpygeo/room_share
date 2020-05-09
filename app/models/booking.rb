class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :guest_nr, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, :end_date, presence: true
  validate :out_greater_than_in

  validate :guest_max


private
  def out_greater_than_in
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

#need to fix the datepicker for booking in the past
  def no_past
    if start_date < Date.now
      errors.add(:end_date, "You can not book in the past")
    end
  end

  def guest_max
    if guest_nr > room.guest_nr
    errors.add(:guest_nr, "Not enough space for everybody,sorry!")
    end
  end
end
