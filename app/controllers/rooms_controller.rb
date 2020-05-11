class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_room, only: [:show, :edit, :update, :destroy]

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
      redirect_to dashboards_path
    else
      render :new
    end
  end

  def edit 
  end

  def update 
    @room.update(room_params)
    redirect_to dashboards_path
  end

  def destroy
      @room.destroy
      redirect_to dashboards_path, notice: 'Room was successfully removed.' 
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :street, :city, :guest_nr, :photo)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
