class CartsController < ApplicationController
  def clean
    current_cart.clean!(current_cart.cart_items)
    redirect_to :back
    flash[:warning] = "已清空购物车！"
  end
end
