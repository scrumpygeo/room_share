class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy ]

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
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully removed.' 
  end

  private

    def set_booking 
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :guests_nr, :status)
    end
  
end