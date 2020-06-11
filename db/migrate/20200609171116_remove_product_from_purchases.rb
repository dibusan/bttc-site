class RemoveProductFromPurchases < ActiveRecord::Migration[5.0]
  def change
    remove_reference :purchases, :product, foreign_key: true
  end
end
