class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end

  def show
  end

  def buy

  end

  private
    def item_params
      params.require(:item).permit(:name, :explain, :category_id, :state, :postage, :region, :shipping_date, :price, item_images_attributes: [:image, :item_id] )
    end
end
