class RemoveProductFromPurchase < ActiveRecord::Migration[5.0]
  def change
    remove_reference :purchases, :product_id
  end
end
