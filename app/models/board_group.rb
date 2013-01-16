class BoardGroup < ActiveRecord::Base
  attr_accessible :name, :order
  has_many :boards

  before_save :init

  def init
    self.order||=(self.class.minimum(:order) || 0) -1
  end

end
