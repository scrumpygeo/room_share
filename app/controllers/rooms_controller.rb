class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_room, only: [:show]
  def index
    @rooms = Room.all.last
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
