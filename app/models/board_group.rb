class BoardGroup < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :name, :order

  has_many :boards

  def as_json(options={})
    attributes_to_json :except=>%w(created_at updated_at)
  end

end
