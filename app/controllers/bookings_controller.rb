class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy ]

  def index 
    # @bookings = Booking.where(user_id: current_user.id).order('start_date ASC')
    @bookings = policy_scope(Booking).where(user_id: current_user.id).order('start_date ASC')
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

    authorize @booking

    if @booking.end_date && @booking.start_date
      @booking.price = (@booking.end_date - @booking.start_date).to_f * @booking.room.price.to_f
    else
      @booking.price = 0
    end
      
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show  
  end

  def destroy
    if @booking.status == 'Pending'
      @booking.destroy
      redirect_to bookings_path, notice: 'Booking was successfully removed.' 
    else
      redirect_to bookings_path, notice: "Sorry. Confirmed bookings can only be cancelled by contacting room owner directly."
    end
  end

  private

    def set_booking 
      @booking = Booking.find(params[:id])
      authorize @booking
    end

    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :guest_nr, :status)
    end
  
end