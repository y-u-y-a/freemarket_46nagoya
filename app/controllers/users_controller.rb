class UsersController < ApplicationController
  require 'payjp'

  before_action :authenticate_user!

  before_action :set_category, only: [ :index, :show, :logout, :payment_method, :card_registration, :indentification, :purchased, :trading, :exhibition, :seller_trading, :sold_page, :notification, :todo, :individual,:following,:followers]
  # ヘッダーに使うカテゴリを読み込む
  before_action :set_user
  # , only: [:trading, :purchased,:index,:show,:update]
  before_action :set_payjp_user ,only: [:card_delete, :card_create, :payment_method, :card_registration]

  before_action :set_search


  before_action :set_price, only: [:index, :show, :logout, :payment_method, :card_registration, :indentification, :purchased, :trading, :exhibition, :seller_trading, :sold_page, :notification, :todo, :individual,:following,:followers]

  before_action :user_late_count ,only: [:individual]


  protect_from_forgery :except => [ :card_create, :card_delete, :payment_method, :card_registration]
  # 外部からのAPIを受ける特定アクションのみ除外

  def index
    @items = Item.where(user_id: current_user)
    @user = User.find(current_user.id)
    @trading_items = Item.includes(:messages).order(updated_at: :desc).where(buyer_id: current_user).where(business_stats: 2)
    @old_items = Item.includes(:messages).order(updated_at: :desc).where(buyer_id: current_user).where(business_stats: 3)
  end

  def show
  end

  def update
    if @user.id == current_user.id
      current_user.update(update_params)
      redirect_to users_path
    else
      render_to :edit
    end
  end

  def logout
  end

  def notification
  end

  def todo
    @trading_items = Item.includes(:messages).order(updated_at: :desc).where(buyer_id: current_user).where(business_stats: 2)
  end

  def payment_method
    if @user.customer_id
      customer = Payjp::Customer.retrieve(@user.customer_id)
      @card = customer.cards.retrieve(customer.default_card)
    end
  end

  def card_registration
  end

  def indentification
  end

  def exhibition
    @item = Item.where(business_stats: 1).where(user_id: current_user.id)
  end

  def seller_trading
    @item = Item.where(business_stats: 2).where(user_id: current_user.id)
  end

  def sold_page
    @item = Item.where(business_stats: 3).where(user_id: current_user.id)
  end

  def trading
    @item = Item.where(business_stats: 2).where(buyer_id: current_user.id)
  end

  def purchased
    @item = Item.where(business_stats: 3).where(buyer_id: current_user.id)
  end

  def transaction_page
    @item = @user.items.find(params[:id])
  end

  def card_create
    #顧客の作成
    card = Payjp::Token.create({
      card: {
        number: params[:number],
        cvc: params[:cvc],
        exp_month: params[:exp_month],
        exp_year: params[:exp_year]
      }},
      {
        'X-Payjp-Direct-Token-Generate': 'true'
      }
    )
    #顧客の作成
    # card: params["payjpToken"]
    customer = Payjp::Customer.create(
      email: @user.email,
      card: card
    )
    #トークンとアプリのユーザーの紐付け
    if @user.update_attribute(:customer_id, customer.id)
      redirect_to payment_method_users_path, success: "登録ができました"
    else
      redirect_to root_path
    end
  end

  def card_delete
    # 顧客の削除
    customer = Payjp::Customer.retrieve(@user.customer_id)
    @user.update_attribute(:customer_id, nil)
    customer.delete
    flash[:notice] = "カードを削除しました"
    redirect_to action: :index
  end

  def individual
    @good = Late.where(user_id: current_user.id).where(late: 1)
    @good_count = @good.length
    @normal = Late.where(user_id: current_user.id).where(late: 2)
    @normal_count = @normal.length
    @bad = Late.where(user_id: current_user.id).where(late: 3)
    @bad_count = @bad.length
    @user = User.find(current_user.id)
    @page_user = User.includes(:items).find(params[:id])
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def set_user
    @user = User.includes(:items).find(current_user)
  end

  def set_payjp_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end

  def update_params
    params.require(:user).permit(:nickname, :profile_text, :avatar, :avatar_cache, :remove_avatar)
  end

end
