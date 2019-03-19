class ItemsController < ApplicationController
  before_action :set_item, only: [:show,:edit, :update, :destroy]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

<<<<<<< HEAD
  def create
    Item.create(item_params)
    redirect_to root_path
  end

=======
>>>>>>> tsurutadesu/master
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
<<<<<<< HEAD
=======

  def buy
>>>>>>> tsurutadesu/master

  def buy
  end

  private
<<<<<<< HEAD
    def item_params
      params.require(:item).permit(:name, :explain, :category_id, :state, :postage, :region, :shipping_date, :price, :way_of_delivery, item_images_attributes: [:item_id, :image]).merge(user_id: current_user.id, business_stats: '1')
    end
=======
  def item_params
    params.require(:item).permit(:name,:price,:explain,:postage,:region,:state,:shipping_date,:shipping_way,:size,:brand_id,:category_id,item_images_attributes: [:image,:item_id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
>>>>>>> tsurutadesu/master
end
