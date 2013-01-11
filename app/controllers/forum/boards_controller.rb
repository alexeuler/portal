class Forum::BoardsController < ApplicationController

  def index
    @boards = Board.sorted_and_grouped
    respond_with @boards
  end
  
  def show
    @board=Board.find(params[:id])    
    respond_with @board
  end

  def update
    @board=Board.find(params[:id])
    keep_only! @board.attribute_names, params[:board]
    @board.update_attributes(params[:board]) ? render(:text=>request_success(self)) : render(:text => request_error(self))
  end

end
