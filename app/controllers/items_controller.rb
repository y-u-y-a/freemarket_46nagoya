class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    @item_image = Item.new(item_image_params)
    @item_image.save
    redirect_to root_path(@item)
  end

  def show
  end

  def buy

  end


  private

    def item_params
      params.permit(name: "", explain: "", category_id: "", state: "", postage: "", region: "", shipping_date: "", price: "")
    end

    def item_image_params
      params.permit(image: "")
    end
end
