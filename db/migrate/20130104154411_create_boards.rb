class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :order
      t.integer :board_group_id
      t.string :description

      t.timestamps
    end
  end
end
