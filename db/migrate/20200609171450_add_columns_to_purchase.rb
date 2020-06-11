class AddColumnsToPurchase < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :total, :integer
    add_column :purchases, :delivery?, :boolean, default: false
  end
end
