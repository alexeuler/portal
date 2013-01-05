class Forum::BoardsController < ApplicationController

  def index
    @boards = Board.sorted_and_grouped
    respond_with @boards
  end
  
  def show
    @board=Board.find(params[:id])    
    respond_with @board
  end

end
