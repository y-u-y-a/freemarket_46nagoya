class ItemsController < ApplicationController

  before_action :set_item, only: [:show,:edit, :update, :destroy]
  before_action :set_category, only: [ :index, :new, :all_brands_show, :all_categories_show, :show]

  def index
    @items = Item.all
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
    @item = Item.create(price: 0)
    10.times {@item.item_images.build}
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      t = 10 - @item.item_images.length
      t.times {@item.item_images.build}
      render new_item_path
    end
  end

  def show
    @images = @item.item_images
    @region = Prefecture.find(@item.region)
  end

  def edit
    images = @item.item_images
    @images = ItemImage.find(images.ids)
    @item_image = @item.item_images.build
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to users_path
    else
      render :show,notice: '削除出来ませんでした'
    end
  end

  def buy
  end

  def all_brands_show
  end

  def all_categories_show
  end

  def category_select
    @child_category = Category.where(main_category_id: params[:item][:category_id]).where(sub_category_id: nil)
  end

  def child_category_select
    child_category = Category.find(params[:item][:child_category_id])
    @grand_child_category = Category.where(main_category_id: child_category.main_category_id).where(sub_category_id: child_category.id)
  end

  private

  def item_params
    params.require(:item).permit( :name, :price, :explain, :postage, :region, :state, :shipping_date, :shipping_way,:size,:brand_id, :category_id, :child_category_id, :grand_child_category_id,item_images_attributes: [:image,:item_id]).merge(user_id: current_user.id, business_stats: '1')
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
