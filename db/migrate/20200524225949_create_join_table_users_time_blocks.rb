class CreateJoinTableUsersTimeBlocks < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :time_blocks do |t|
      t.index [:user_id, :time_block_id]
      t.index [:time_block_id, :user_id]
    end
  end
end
