class Forum::BoardGroupsController < ApplicationController

  def index
    @board_group = BoardGroup.order("'order'")
    respond_with @board_group
  end

  def show
    @board_group=BoardGroup.find(params[:id])    
    respond_with @board_group
  end

end
