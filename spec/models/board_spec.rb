require 'spec_helper'

describe Board do
  describe 'sorted_and_grouped scope' do
    it 'returns boards with board_groups sorted first by group order, then by order' do
      fixtures=FactoryGirl.create_list(:board, 9)
      sorted_fixtures=[9,8,7,3,2,1,4,5,6].map {|i| fixtures[i-1]}
      boards=Board.sorted_and_grouped
      sorted_fixtures.each_with_index {|board, i| board.as_json.should == boards[i].as_json}
    end
  end

  describe 'as_json' do
    it 'renders json with board_group included, no created_at, updated_at' do
      board=FactoryGirl.create(:board)
      hash={}
      board.attribute_names.each do |attr|
        hash[attr]=board.send attr.to_sym unless %w(created_at updated_at).include?(attr)
      end

      hash['board_group']={}
      board.board_group.attribute_names.each do |attr|
        hash['board_group'][attr]=board.board_group.send attr.to_sym unless %w(created_at updated_at).include?(attr)
      end

      hash.should == board.as_json

    end
  end
  
end
