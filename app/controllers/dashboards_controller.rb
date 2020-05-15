class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show]

  def index 
    # @rooms = Room.where(user: current_user).order('name ASC')
    @rooms = policy_scope(Room).where(user: current_user).order(city: :asc)   # works but not dry so not correct
    # @rooms = policy_scope(Room).order(city: :asc)
  end

  def show 
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :street, :city, :guest_nr, :photo)
  end

  def set_room
    @room = Room.find(params[:id])
    authorize @room
  end
end