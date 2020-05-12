class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show]

  def index 
    @rooms = Room.where(user: current_user).order('name ASC')
  end

  def show 
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :street, :city, :guest_nr, :photo)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end