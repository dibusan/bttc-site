class CreateTimeBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :time_blocks do |t|
      t.datetime :block_start_time
      t.integer :availability

      t.timestamps
    end
  end
end
