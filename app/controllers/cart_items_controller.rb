class CartItemsController < ApplicationController
  def destroy
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    redirect_to :back
    flash[:warning] = "已删除商品#{@product.title}"
  end

  def update
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.update(cart_item_params)
    redirect_to :back
    flash[:warning] = "已更新商品#{@product.title}的数量"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
