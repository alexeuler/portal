class Forum::BoardsController < ApplicationController

  def index
    @model = Board.sorted_and_grouped
    respond_with @model
  end
  
  def show
    @model=Board.find(params[:id])    
    respond_with @model
  end

  def update
    @model=Board.find(params[:id])
    keep_only! @model.attribute_names, params[:board]
    @model.update_attributes(params[:board]) ? render(:text=>request_success(self)) : render(:text => request_error(self))
  end

end
