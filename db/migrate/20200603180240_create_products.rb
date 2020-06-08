class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :product_category
      t.boolean :used?, default: false
      t.datetime :released_date
      t.integer :msrp
      t.integer :age
      t.integer :count

      t.timestamps
    end
  end
end
