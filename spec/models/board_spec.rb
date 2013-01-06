require 'spec_helper'
require 'helpers'

RSpec.configure do |c|
  c.include RSpec::Helpers
end

describe Board do
  before(:each) do
    FactoryGirl.reload
  end

  describe 'sorted_and_grouped scope' do
    it 'returns boards with board_groups sorted first by group order, then by order' do
      fixtures=FactoryGirl.create_list(:board, 9)
      sorted_fixtures=[9,8,7,3,2,1,4,5,6].map {|i| fixtures[i-1]}
      boards=Board.sorted_and_grouped
      sorted_fixtures.each_with_index {|fixture, i| fixture.as_json.should == boards[i].as_json}
    end
  end

  describe 'as_json' do
    it 'renders json with board_group included; created_at, updated_at excluded' do
      board=FactoryGirl.build(:board)
      hash=model_to_hash board, :exclude=>%w(created_at updated_at)
      hash['board_group']=model_to_hash board.board_group, :exclude=>%w(created_at updated_at)
      hash.should == board.as_json
    end
  end
  
end
