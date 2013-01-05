class Board < ActiveRecord::Base
  include ApplicationHelper

  attr_accessible :board_group_id, :description, :name, :order, :board_group
  belongs_to :board_group

  def as_json(options={})
#    json={}
#    attribute_names.each do |attr|
#      json[attr]=send(attr.to_sym)
#    end
    json=attributes_to_json :except=>%w(created_at updated_at)
    json["board_group"]=board_group
    json
  end

end
