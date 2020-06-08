class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :paid
      t.boolean :fulfilled?, default: false
      t.date :fulfillment
      t.text :notes

      t.timestamps
    end
  end
end
