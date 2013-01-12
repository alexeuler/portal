class Forum::BoardGroupsController < ApplicationController

  def index
    @board_group = BoardGroup.order("'order'")
    respond_with @board_group
  end

  def show
    @board_group=BoardGroup.find(params[:id])    
    respond_with @board_group
  end

  def update
    @board_group=BoardGroup.find(params[:id])
    @board_group.update_attributes(params[:board_group]) ? render(:text=>request_success(self)) : render(:text => request_error(self))
  end

end
