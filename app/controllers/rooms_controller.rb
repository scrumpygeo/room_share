class RoomsController < ApplicationController
  def index
    @rooms = Room.all.last
  end
end
