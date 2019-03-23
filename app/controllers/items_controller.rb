class ItemsController < ApplicationController

  require 'payjp'

  before_action :set_category, only: [ :index, :new, :all_brands_show, :all_categories_show, :show]
  before_action :set_item, only: [:show ,:edit, :update, :destroy, :buy]
  before_action :set_payjp_user ,only: [:buy, :pay]

  def index
    items = Item.order("created_at DESC")
    @lady_items = items.where(category_id: 1).where(business_stats: 1).first(4)
    @man_items = items.where(category_id: "2").where(business_stats: 1).first(4)
    @kids_items = items.where(category_id: "3").where(business_stats: 1).first(4)
    @cosmetic_items = items.where(category_id: "6").where(business_stats: 1).first(4)
    @chanel_items = items.where(brand_id: "1").where(business_stats: 1).first(4)
    @nike_items = items.where(brand_id: "2").where(business_stats: 1).first(4)
    @vuitton_items = items.where(brand_id: "3").where(business_stats: 1).first(4)
    @supreme_items = items.where(brand_id: "4").where(business_stats: 1).first(4)
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    Item.create(item_params)
    redirect_to root_path(@item)
  end

  def show
    @images = @item.item_images
    @region = Prefecture.find(@item.region)
  end

  def edit
    @images = @item.item_images
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      redirect_to edit_item_path(@item)
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
    if @user.customer_id
      customer = Payjp::Customer.retrieve(@user.customer_id)
      @card = customer.cards.retrieve(customer.default_card)
    else
      redirect_to payment_method_users_path
    end
    @images = @item.item_images
    @region = Prefecture.find(@item.region)
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

  def pay
    @item = Item.find(params[:id])
    if @user.customer_id == nil
      redirect_to payment_method_users_path
    else
      @charge = Payjp::Charge.create(
        :amount => @item.price,
        :customer => @user.customer_id,
        :currency => 'jpy',
      )
      @item.buyer_id = current_user.id
      @item.business_stats = '3'
      if @item.save
        redirect_to root_path, notice: '購入しました'
      else
        render :buy, notice: '購入出来ませんでした'
      end
    end
  end

  private

  def item_params
    params.require(:item).permit( :name, :price, :explain, :postage, :region, :state, :shipping_date, :shipping_way,:size,:brand_id, :category_id, :child_category_id, :grand_child_category_id, item_images_attributes: [:image,:item_id]).merge(user_id: current_user.id, business_stats: '1')
  end

  def pay_item_params
    params.permit(:item_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_payjp_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end
end
