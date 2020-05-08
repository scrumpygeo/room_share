class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_room, only: [:show]

  def index

    @search = params["search"]
    if @search.present?
      @city = @search["city"]
      @rooms = Room.where("city ILIKE ?", "%#{@city}%")
    end

    if @rooms.blank?
      @rooms = Room.all
      flash[:notice] = "Sorry. We didn't find any suitable rooms in that area. Please try again!"
    end

    # @rooms = Room.geocoded # returns rooms with coordinates

    @markers = @rooms.map do |room|
      {
        lat: room.latitude,
        lng: room.longitude
      }
    end

  end

  def show
    @booking = Booking.new
  end

  private

  def room_params
    params.require(:room).permit(:name, :describe, :price, :address, :city, :guest_nr, :photo)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
