class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total_price = current_cart.total_price(current_cart.cart_items)
    if
      @order.save
      @product_list = ProductList.new
      @product_list.order = @order
      current_cart.cart_items.each do |cart_item|
        @product_list.product_name = cart_item.product.title
        @product_list.product_price = cart_item.product.price
        @product_list.product_quantity = cart_item.quantity
      end
      @product_list.save
      current_cart.clean!(current_cart.cart_items)
      OrderMailer.notice_order_placed(@order).deliver!
      # 原来路由后面的参数是在controller的这个路由辅助方法里面注入的
      redirect_to order_path(@order.token)
    else
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end

  def pay_with_alipay
    @order = Order.find_by_token(params[:id])
    @order.make_payment!
    @order.set_paymeny_with_method("alipay")
    redirect_to :back
    flash[:notice] = "已用支付宝完成付款！"
  end

  def pay_with_alipay
    @order = Order.find_by_token(params[:id])
    @order.make_payment!
    @order.set_paymeny_with_method("wechat")
    redirect_to :back
    flash[:notice] = "已用微信完成付款！"
  end

  def apply_to_cancel
    @order = Order.find_by_token(params[:id])
    OrderMailer.apply_cancel(@order).deliver!
    redirect_to :back
    flash[:notice] = "已提交申请取消订单！"
  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shopping_name, :shopping_address)
  end
end
