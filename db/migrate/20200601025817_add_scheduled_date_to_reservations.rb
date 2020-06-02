class AddScheduledDateToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :scheduled_for, :datetime
    remove_reference :reservations, :time_block
  end
end
