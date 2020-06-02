class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :coach, foreign_key: { to_table: 'user' }
      t.references :user, foreign_key: true
      t.references :time_block, foreign_key: true
      t.integer :club_table
      t.integer :party_size, default: 1
      t.boolean :type_play?, default: true
      t.boolean :type_lesson?

      t.timestamps
    end
  end
end
