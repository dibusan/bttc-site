class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :member?, :boolean, default: false
    add_column :users, :membership_type, :integer, default: 0
    add_column :users, :membership_start_date, :datetime
    add_column :users, :membership_end_date, :datetime
    add_column :users, :total_paid, :integer
  end
end
