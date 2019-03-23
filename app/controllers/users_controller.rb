class UsersController < ApplicationController

  require 'payjp'

  before_action :authenticate_user!, only: [:payment_method, :card_registration, :indentification, :card_create, :card_delete]

  before_action :set_category, only: [ :index, :show, :logout, :payment_method, :card_registration, :indentification, :purchased, :trading, :exhibition, :seller_trading, :sold_page]
  # ヘッダーに使うカテゴリを読み込む
  before_action :set_user, only: [:trading, :purchased]

  before_action :set_payjp_user ,only: [:card_delete, :card_create, :payment_method, :card_registration]

  protect_from_forgery :except => [ :card_create, :card_delete, :payment_method, :card_registration]
  # 外部からのAPIを受ける特定アクションのみ除外

  def index
  end

  def update
  end

  def to_signup
  end

  def logout
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


  private

  def set_user
    @user = User.find(current_user)
  end

  def set_payjp_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end

end
