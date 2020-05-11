class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_room, only: [:show,  :create]

  def index
    
    @search = params["search"]
    if @search.present?
      @city = @search["city"]
      @rooms = Room.where("city ILIKE ?", "%#{@city}%")
    end

    if @rooms.blank?
      @msg = "Sorry. No suitable rooms in your desired location. Please try again."
      @rooms = Room.all
    end

    # @rooms = Room.geocoded # returns rooms with coordinates
    @markers = @rooms.map do |room|
      {
        lat: room.latitude,
        lng: room.longitude,
        infowindow: render_to_string(partial: "infowindow", locals: { room: room }) 
      }
    end

    flash[:notice] = @msg
  end

  def show
    @booking = Booking.new
  end

  def new
    @room = Room.new
  end

  def create 
    # @booking = Booking.new(flat_params)
    @room = Room.new(room_params)
    @room.user = current_user
    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :describe, :price, :address, :city, :guest_nr, :photo)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
