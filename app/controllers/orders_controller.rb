class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total_price = current_cart.total_price(current_cart.cart_items)
    if
      @order.save
      
      redirect_to order_path(@order)
    else
      render "carts/checkout"
    end
  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shopping_name, :shopping_address)
  end
end
