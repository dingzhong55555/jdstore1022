class CartItemsController < ApplicationController
  def destroy
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    redirect_to :back
    flash[:warning] = "已删除商品#{@product.title}"
  end
end
