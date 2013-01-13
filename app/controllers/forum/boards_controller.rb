class Forum::BoardsController < ApplicationController

  def index
    @model = Board.sorted_and_grouped
    respond_with @model
  end
  
  def show
    @model=Board.find(params[:id])    
    respond_with @model
  end

  def create
    @group=BoardGroup.find_or_create_by_name params[:board][:board_group][:name]
    params[:board][:board_group_id]=@group.id
    keep_only! Board.attribute_names, params[:board]
    @model=Board.create(params[:board])    
    render(:text=>request_success(self))
  end

  def update
    @model=Board.find(params[:id])
    keep_only! Board.attribute_names, params[:board]
    @model.update_attributes(params[:board]) ? render(:text=>request_success(self)) : render(:text => request_error(self))
  end

end
