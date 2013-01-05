class Forum::BoardsController < ApplicationController

  def index
    @boards = Board.includes(:board_group)
    respond_with @boards
  end
  
  def show
    @board=Board.find(params[:id])    
    respond_with @board
  end

end
