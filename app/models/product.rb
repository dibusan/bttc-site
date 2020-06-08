class Product < ApplicationRecord
  enum product_category: [:services, :rubbers, :rackets, :blades, :shoes, :balls]

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end
end
