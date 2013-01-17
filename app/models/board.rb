class Board < ActiveRecord::Base
  scope :sorted_and_grouped, includes("board_group").order('"board_groups"."order", "boards"."order"')

  attr_accessible :board_group_id, :description, :name, :order, :board_group
  belongs_to :board_group

  before_save :init

  def init
    order||=(self.class.where(:board_group_id=>self.board_group_id).minimum(:order) || 0) - 1
  end


  def as_json(options={})
    json=super(options)
    json["board_group"]=board_group.as_json
    json
  end

end
