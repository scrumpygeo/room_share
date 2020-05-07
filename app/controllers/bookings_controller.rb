class BookingsController < ApplicationController

def index 
  @bookings = Booking.where(user_id: current_user.id)
end

  def new
  @room = Room.find([:room_id])
  @booking = Booking.new
end


def create
  @room = Room.find(params[:room_id])
  @booking = Booking.new(booking_params)
  @booking.room = @room
  @booking.user = current_user
  @booking.status = "Pending"
 
  if @booking.save
    redirect_to booking_path(@booking)
  else
    render :new
  end
end

  def show
    @booking = Booking.find(params[:id])
  end

  private

    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :guests_nr, :status)
    end
  
end