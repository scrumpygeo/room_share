class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_room, only: [:show]

  def index

    if params[:query].present?
      @rooms = Room.where(city: params[:query])
      if @rooms.blank?
        @rooms = Room.all
        # send message
      end
    else
      @rooms = Room.all
    end
  end

  def show
  end

  private

  def room_params
    params.require(:room).permit(:name, :describe, :price, :address, :city, :guest_nr, :photo)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
