class ChargesController < ApplicationController
  class StripeChargesServices
    DEFAULT_CURRENCY = 'usd'.freeze

    def initialize(params, user)
      @stripe_email = params[:stripeEmail]
      @stripe_token = params[:stripeToken]
      @order = params[:order_id]
      @user = user
    end

    def call
      create_charge(find_customer)
    end

    private

    attr_accessor :user, :stripe_email, :stripe_token, :order

    def find_customer
      if user.stripe_token
        retrieve_customer(user.stripe_token)
      else
        create_customer
      end
    end

    def retrieve_customer(stripe_token)
      Stripe::Customer.retrieve(stripe_token)
    end

    def create_customer
      customer = Stripe::Customer.create(
        email: stripe_email,
        source: stripe_token
      )
      user.update(stripe_token: customer.id)
      customer
    end

    def create_charge(customer)
      Stripe::Charge.create(
        customer: customer.id,
        amount: order_amount,
        description: customer.email,
        currency: DEFAULT_CURRENCY
      )
    end

    def order_amount
      Purchase.find_by(id: order).total
    end
  end


  rescue_from Stripe::CardError, with: :catch_exception

  def new
    cart_ids = $redis.smembers current_user_cart
    @products = Product.find(cart_ids)
    @order = current_user.purchases.create!(
      products: @products,
      total: @products.map(&:price_in_cents).inject(0, &:+)
    )
  end

  def create
    StripeChargesServices.new(charges_params, current_user).call
    flash[:success] = "Order Placed!"
    redirect_to clear_cart_url
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :order_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end

end
