class Forum::BoardGroupsController < ApplicationController

  def index
    @model = BoardGroup.order("'order'")
    respond_with @model
  end

  def show
    @model=BoardGroup.find(params[:id])    
    respond_with @model
  end

  def update
    @model=BoardGroup.find(params[:id])
    @model.update_attributes(params[:board_group]) ? render(:text=>request_success(self)) : render(:text => request_error(self))
  end

end
