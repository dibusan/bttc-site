class Product < ApplicationRecord
  has_and_belongs_to_many :purchases

  enum product_category: [:services, :rubbers, :rackets, :blades, :shoes, :balls]

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end

  def price
    (price_in_cents/100.0).to_f
  end
end
