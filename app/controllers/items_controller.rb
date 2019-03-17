class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @order = Order.new
    @item = Item.new
    @item.item_images.build
  end

  def create
    Item.create(item_params)
    Order.create(order_params)
    redirect_to root_path(@item)
  end

  def show
  end

  def buy

  end

  private
    def item_params
      params.require(:item).permit(:name, :explain, :category_id, :state, :postage, :region, :shipping_date, :price, :way_of_delivery, item_images_attributes: [:item_id, :image],order_images_attributes: [:businnes_stats, :item_id])
    end

    def order_params
      binding.pry
      params.require(:item).permit(:businnes_stats, :item_id)
    end
end
