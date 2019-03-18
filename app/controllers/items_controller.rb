class ItemsController < ApplicationController


  def index
    items = Item.order("created_at DESC")
    @lady_items = items.where(category_id: "1").first(4)
    @man_items = items.where(category_id: "2").first(4)
    @kids_items = items.where(category_id: "3").first(4)
    @cosmetic_items = items.where(category_id: "6").first(4)
    @chanel_items = items.where(brand_id: "1").first(4)
    @nike_items = items.where(brand_id: "2").first(4)
    @vuitton_items = items.where(brand_id: "3").first(4)
    @supreme_items = items.where(brand_id: "4").first(4)
  end

  def new
  end


  def show
  end

  def buy

  end
end
