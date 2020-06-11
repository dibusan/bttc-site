class CreateJoinTableProductsPurchases < ActiveRecord::Migration[5.0]
  def change
    create_join_table :products, :purchases do |t|
      t.index [:product_id, :purchase_id]
      t.index [:purchase_id, :product_id]
    end
  end
end
