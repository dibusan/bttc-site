class AddUserToDayblock < ActiveRecord::Migration[5.0]
  def change
    add_reference :day_blocks, :coach, foreign_key: {to_table: :users}
  end
end
