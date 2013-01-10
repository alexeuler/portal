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
    params[:board].delete 'board_group'
    if @board.update_attributes(params[:board]) 
      render :text=>'Ok'
    else
      render :text=>'Error'
    end

  end

end
