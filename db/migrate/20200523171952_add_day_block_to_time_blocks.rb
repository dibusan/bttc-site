class AddDayBlockToTimeBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :time_blocks, :day_block, foreign_key: true
  end
end
