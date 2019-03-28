class ItemsController < ApplicationController
  require 'payjp'

  # before_action :authenticate_user!

  before_action :set_category,     only: [ :index, :new, :all_brands_show, :all_categories_show, :show, :item_search_result]
  before_action :set_item,         only: [:show ,:edit, :update, :destroy, :buy]
  before_action :set_payjp_user ,  only: [:buy, :pay]
  before_action :set_search
  before_action :set_searches ,    only: [:item_search_result]

  before_action :set_user, only: :index
  before_action :get_category, only: [:show,:edit]

  def index
    @lady_items = Item.where(category_id: 1).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @man_items = Item.where(category_id: 2).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @kids_items = Item.where(category_id: 3).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @cosmetic_items = Item.where(category_id: 6).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @chanel_items = Item.where(brand_id: 1).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @nike_items = Item.where(brand_id: 2).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @vuitton_items = Item.where(brand_id: 3).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @supreme_items = Item.where(brand_id: 4).where.not(business_stats: 2).limit(4).order(id: "DESC")

    @chanel = 'シャネル'
    @nike = 'ナイキ'
    @vuitton = 'ヴィトン'
    @supreme = 'シュプリーム'

    @category_name = []
    @category_name << Category.find(1)
    @category_name << Category.find(2)
    @category_name << Category.find(3)
    @category_name << Category.find(6)

    @category_items = [ @lady_items, @man_items, @kids_items, @cosmetic_items]
    @brand_items = [ @chanel_items, @nike_items, @vuitton_items, @supreme_items]
    @brand_names = [ @chanel, @nike, @vuitton, @supreme]
  end

  def new
    @item = Item.create(price: 0)
    30.times {@item.item_images.build}
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      t = 30 - @item.item_images.length
      t.times {@item.item_images.build}
      render new_item_path
    end
  end

  def show
    @region = Prefecture.find(@item.region)
    @user_items = Item.where(user_id: @item.user.id).where.not(id: params[:id]).limit(6)
    @category_items = Item.where(grand_child_category_id: @grand_category.id).where.not(user_id: @item.user.id).all
  end

  def edit
    10.times {@item.item_images.build}
  end

  def update
    if @item.update(update_params)
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

  def item_search_result
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
    params.require(:item).permit( :name, :price, :explain, :postage, :region, :state, :shipping_date, :shipping_way,:size,:brand_id, :category_id, :child_category_id, :grand_child_category_id, item_images_attributes: [:image]).merge(user_id: current_user.id, business_stats: '1')
<<<<<<< HEAD
=======
  end

  def update_params
    params.require(:item).permit( :name, :price, :explain, :postage, :region, :state, :shipping_date, :shipping_way,:size,:brand_id, :category_id, :child_category_id, :grand_child_category_id, item_images_attributes: [:image,:id,:_destroy]).merge(user_id: current_user.id, business_stats: '1')
>>>>>>> tsurutadesu/master
  end

  def pay_item_params
    params.permit(:item_id)
  end

  def get_category
    @parent_category,@children_category,@grand_category = Category.find(@item.category_id,@item.child_category_id,@item.grand_child_category_id)
  end

  def set_item
    @item = Item.includes([:user,:item_images,:likes]).find(params[:id])
  end

  def set_user
    @user = User.includes(:items).find(current_user) if user_signed_in?
  end

  def set_payjp_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end
end
