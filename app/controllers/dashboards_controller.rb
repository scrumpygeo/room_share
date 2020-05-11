class DashboardsController < ApplicationController
  def index 
    @rooms = Room.where(user: current_user).order('name ASC')
  end
end