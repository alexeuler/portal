class BoardGroup < ActiveRecord::Base
  attr_accessible :name, :order

  has_many :boards

end
