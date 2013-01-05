FactoryGirl.define do 

  sequence(:parent) {|n| (n+2)/3}
  

# Generates board, each 3rd board belongs_to new board_group
# Each 2nd board_group is inverted order both - itself and boards
  factory :board do

    sequence(:name) {|n| "Board#{n}"}
    sequence(:description) {|n| "Description#{n}"}
    sequence(:order) {|n| n}

    after(:build) do |board|
      group_id=FactoryGirl.generate(:parent)
      inverted= (group_id%2 == 1)
      board.order=-board.order if inverted
      group=BoardGroup.find_by_id(group_id) || FactoryGirl.create(:board_group, :inverse => inverted)
      board.board_group=group
    end

  end


  factory :board_group do
    ignore do 
      inverse false      
    end

    sequence(:name) {|n| "Group#{n}"}
    sequence(:order) {|n| n}

    after(:build) do |board_group, evaluator|
      board_group.order=-board_group.order if evaluator.inverse
    end

  end
end
