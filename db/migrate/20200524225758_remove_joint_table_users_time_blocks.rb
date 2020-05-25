class RemoveJointTableUsersTimeBlocks < ActiveRecord::Migration[5.0]
  def change
    drop_table :time_blocks_users
  end
end
