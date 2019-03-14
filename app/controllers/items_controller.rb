class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item_image = Item.new
  end

  def create
    @item = Item.new(item_params)
    binding.pry
    @item.save
    redirect_to root_path(@item)
  end

  def show
  end

  def buy

  end

  private
    def item_params
      params.permit(:name, :explain, :category_id, :state, :postage, :region, :shipping_date, :price)
    end
end
