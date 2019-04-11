class ItemsController < ApplicationController
  require 'payjp'

  before_action :authenticate_user! ,   only: [:new ,:buy, :pay]
  before_action :address_create,        only: [:buy, :pay]
  before_action :set_category,          only: [ :index, :new, :edit, :create, :update, :all_brands_show, :all_categories_show, :show, :item_search_result, :trading_message]
  before_action :set_item,              only: [:show ,:edit, :update, :destroy, :buy, :message]
  before_action :set_payjp_user ,       only: [:buy, :pay]
  before_action :set_search
  before_action :set_searches ,         only: [:item_search_result]
  before_action :category_in_brand ,    only: [:all_brands_show]
  before_action :set_user,              only: [:index,:show]
  before_action :get_category,          only: [:show, :edit]
  before_action :set_price,             only: [:index, :new, :edit, :create, :update, :all_brands_show, :all_categories_show, :show, :item_search_result, :trading_message]
  before_action :set_late_count ,       only: :show

  def index
    @lady_items = Item.where(category_id: 1).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @man_items = Item.where(category_id: 2).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @kids_items = Item.where(category_id: 3).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @cosmetic_items = Item.where(category_id: 6).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @chanel_items = Item.where(brand_id: 2447).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @nike_items = Item.where(brand_id: 3813).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @vuitton_items = Item.where(brand_id: 6155).where.not(business_stats: 2).limit(4).order(id: "DESC")
    @supreme_items = Item.where(brand_id: 8413).where.not(business_stats: 2).limit(4).order(id: "DESC")

    @chanel = 'シャネル'
    @nike = 'ナイキ'
    @vuitton = 'ルイ ヴィトン'
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
    @item = Item.new
    30.times {@item.item_images.build}
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @item = Item.new(item_params)
    brand_id = Brand.find_by(name: params[:item][:brand_id])
    @item.brand_id = brand_id.id if brand_id.present?
    if @item.save
      redirect_to root_path
    else
      check_item_name(@item.name)
      check_price(@item.price)
      check_explain(@item.explain)
      check_image(@item.item_images)
      check_category(@item.category_id,@item.child_category_id)
      check_state(@item.state)
      check_region(@item.region)
      check_postage(@item.postage)
      check_date(@item.shipping_date)
      check_way(@item.shipping_way)
      t = 30 - @item.item_images.length
      t.times {@item.item_images.build}
      @item.valid?
      render new_item_path
    end
  end

  def show
    @region = Prefecture.find(@item.region)
    @user_items = Item.where(user_id: @item.user.id).where.not(id: params[:id]).limit(6)
    @comment = Comment.new
    @comments = @item.comments
    if @grand_category == nil
      @child_category_items = Item.where(child_category_id: @children_category.id).where.not(user_id: @item.user.id).all
    else
      @grand_category_items = Item.where(grand_child_category_id: @grand_category.id).where.not(user_id: @item.user.id).all
    end
  end

  def edit
    20.times{@item.item_images.build}
    @child_category = Category.where.not(main_category_id: nil).where(sub_category_id: nil)
    @grand_child_category = Category.where.not(main_category_id: nil).where.not(sub_category_id: nil)
  end

  def update
    if @item.update(update_params)
      redirect_to item_path(@item)
    else
      check_item_name(@item.name)
      check_price(@item.price)
      check_image(@item.item_images)
      check_explain(@item.explain)
      check_category(@item.category_id,@item.child_category_id)
      check_state(@item.state)
      check_region(@item.region)
      check_postage(@item.postage)
      check_date(@item.shipping_date)
      check_way(@item.shipping_way)
      t = 20 - @item.item_images.length
      t.times {@item.item_images.build}
      @child_category = Category.where.not(main_category_id: nil).where(sub_category_id: nil)
      @grand_child_category = Category.where.not(main_category_id: nil).where.not(sub_category_id: nil)
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

  def item_search_result
    @category2 = Category.where.not(main_category_id: nil).where(sub_category_id: nil)
    @category3 = Category.where.not(main_category_id: nil).where.not(sub_category_id: nil)
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
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
    @buyer = User.find(@item.buyer_id)
    if @user.customer_id == nil
      redirect_to payment_method_users_path
    else
      @charge = Payjp::Charge.create(
        :amount => @item.price,
        :customer => @user.customer_id,
        :currency => 'jpy',
      )
      @item.delivery_status = '3'
      @item.business_stats = '3'
      @late = Late.new(late_params)
      @late.user_id = @item.user_id
      @late.late_user = @item.buyer_id
      @buyer.late_count += 1
      @buyer.save(validate: false)
      @late.save(validate: false)
      if @item.save(validate: false)
        redirect_to trading_message_item_path, notice: '購入しました'
      else
        render :buy, notice: '購入出来ませんでした'
      end
    end
  end

  def trading_message
    @item = Item.find(params[:id])
    @user = User.find(current_user)
    @buyer = User.find(@item.buyer_id)
    @address = Address.find_by(user_id: @item.buyer_id)
    @prefecture = Prefecture.find(@address.prefecture_id)
    @message = Message.new
    @messages = Message.where(item_id: @item.id)
    @late = Late.new
  end

  def trading_page
    @item = Item.find(params[:id])
    @seller = User.find(@item.user_id)
    if @item.delivery_status == 1
      @late = Late.new(late_params)
      @late.user_id = @item.buyer_id
      @late.late_user = @item.user_id
      @seller.late_count += 1
      @seller.save(validate: false)
      @late.save(validate: false)
    end
    if @item.business_stats == 1
      @item.buyer_id = current_user.id
      @item.business_stats = 2
      @item.save(validate: false)
    else
      @item.delivery_status += 1
      @item.save(validate: false)
    end
    redirect_to trading_message_item_path
  end

  def message
    @message = Message.new(message_params)
    @message.save
    redirect_to trading_message_item_path
  end

  def address_create
    redirect_to edit_user_address_path(current_user,current_user&.address) if current_user.address.town.nil?
  end

  private
  def item_params
    params.require(:item).permit( :name, :price, :explain, :postage, :region, :state, :shipping_date, :shipping_way,:size, :brand_id, :category_id, :child_category_id, :grand_child_category_id, item_images_attributes: [:image]).merge(user_id: current_user.id, business_stats: '1')
  end

  def update_params
    params.require(:item).permit( :name, :price, :explain, :postage, :region, :state, :shipping_date, :shipping_way,:size,:brand_id, :category_id, :child_category_id, :grand_child_category_id, item_images_attributes: [:id,:image,:_destroy]).merge(user_id: current_user.id)
  end

  def pay_item_params
    params.permit(:item_id)
  end

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, item_id: params[:id])
  end

  def late_params
    params.require(:late).permit(:text, :late)
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
    redirect_to new_user_session_path unless current_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end

  def check_item_name(name)
    flash[:name] = "名前入力してください" if name.blank?
    flash[:name] = "40 文字以下で入力してください" if name.length > 40
  end

  def check_image(image)
    flash[:image] = "画像がありません" if image == []
  end

  def check_explain(explain)
    flash[:explain] = "説明入力してください" if explain.blank?
    flash[:explain] = "1000文字以下で入力してください" if explain.length > 1000
  end

  def check_price(price)
    flash[:price] = "300以上9999999以下で入力してください" if price.nil? || price < 300 || price > 9999999
  end

  def check_category(category,child)
    flash[:category] = "選択してください" if category.nil? || child.nil? || category == 0 || child == 0
  end

  def check_state(state)
    flash[:state] = "選択してください" if state.nil?
  end

  def check_region(region)
    flash[:region] = "選択してください" if region == ""
  end

  def check_postage(postage)
    flash[:postage] =  "選択してください" if postage.nil?
  end

  def check_date(date)
    flash[:shipping_date] = "選択してください" if date.nil?
  end

  def check_way(way)
    flash[:shipping_way] = "選択してください" if way.nil?
  end

end
