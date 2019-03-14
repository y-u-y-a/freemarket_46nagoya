class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
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
      params.require(:item).permit(:image, :name, :explain, :category_id, :state, :postage, :region, :shipping_date, :price)
    end
end
