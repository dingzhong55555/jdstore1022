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
    if @cart_item.quantity <= @product.quantity
      @cart_item.update(cart_item_params)
      flash[:notice] = "已更新商品#{@product.title}的数量"
    else
      flash[:warning] = "商品#{@product.title}的数量不足"
    end

    redirect_to :back
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
