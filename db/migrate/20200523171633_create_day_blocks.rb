class CreateDayBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :day_blocks do |t|
      t.datetime :schedule_date

      t.timestamps
    end
  end
end
