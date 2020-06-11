class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_products = Product.find(cart_ids)
  end

  def add
    $redis.sadd current_user_cart, params[:product_id]
    redirect_to :back
  end

  def remove
    $redis.srem current_user_cart, params[:product_id]
    redirect_to :back
  end

  def clear
    keys = $redis.keys current_user_cart
    $redis.del keys unless keys.empty?
    redirect_to :products
  end
end
