class UsersController < ApplicationController
  require 'payjp'

  before_action :authenticate_user!, only: [:buy, :pay]

  before_action :set_category, only: [ :index, :show, :logout, :payment_method, :card_registration, :indentification, :purchased, :trading, :exhibition, :seller_trading, :sold_page, :notification, :todo, :individual,:following,:followers, :card_create]
  # ヘッダーに使うカテゴリを読み込む
  before_action :set_payjp_user ,only: [:card_delete, :card_create, :payment_method, :card_registration]
  before_action :set_user, only: [:show,:update,:transaction_page,:following,:followers,:individual]
  before_action :set_search
  before_action :set_price, only: [:index, :show, :logout, :payment_method, :card_registration, :indentification, :purchased, :trading, :exhibition, :seller_trading, :sold_page, :notification, :todo, :individual,:following,:followers]
  before_action :user_late_count ,only: [:individual]

  protect_from_forgery :except => [ :card_create, :card_delete, :payment_method, :card_registration]
  # 外部からのAPIを受ける特定アクションのみ除外

  def index
    @user = User.find(current_user)
    @todo_items = Item.includes(:messages,:item_images).where(user_id: current_user).where(business_stats: 2)
    @trading_items = Item.includes(:messages,:item_images).where(buyer_id: current_user).where(business_stats: 2)
    @old_items = Item.includes(:messages,:item_images).order(updated_at: :desc).where(buyer_id: current_user).where(business_stats: 3)
  end

  def show
    @user = User.find(current_user)
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
    @todo_items = Item.includes(:messages,:item_images).order(updated_at: :desc).where(user_id: current_user).where(business_stats: 2)
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
    @user = User.find(current_user)
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
    check = true

    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    begin
      Payjp::Token.create({
        card: {
          number: params[:number].gsub("-",""),
          cvc: params[:cvc],
          exp_month: params[:exp_month],
          exp_year: params[:exp_year]
        }},
        {
          "X-Payjp-Direct-Token-Generate": "true"
        })
    rescue
      check = false
      @error = []
      @error << "カードの登録に失敗しました"
      @error << check_number(params[:number].gsub("-",""))
      @error << check_select(params[:exp_year], params[:exp_month])
      @error << check_cvc(params[:cvc])
      @error = @error.compact
    end

    if check == true
      card = Payjp::Token.create({
        card: {
          number: params[:number].gsub("-",""),
          cvc: params[:cvc],
          exp_month: params[:exp_month],
          exp_year: params[:exp_year]
        }},
        {
          "X-Payjp-Direct-Token-Generate": "true"
        })
      customer = Payjp::Customer.create(
        email: @user.email,
        card: card
      )
      if @user.update_attribute(:customer_id, customer.id)
        redirect_to payment_method_users_path, success: "登録ができました"
      else
        redirect_to root_path
      end
    else
      render :card_registration
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
  end

  def following
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @users = @user.followers
    render 'show_follower'
  end

  private

  def set_user
    @user = User.includes(:items).find(params[:id])
  end

  def set_payjp_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end

  def update_params
    params.require(:user).permit(:nickname, :profile_text, :avatar, :avatar_cache, :remove_avatar)
  end

  def check_number(number)
    return "カードナンバーは14桁から17桁で入力してください" if (number.length < 14) || (number.length > 17)
  end

  def check_select(exp_year, exp_month)
    date = Date.today
    date = "#{date.year}#{date.month}".to_i
    exp_select = "#{exp_year}#{exp_month}".to_i
    error = "有効期限が切れています" if exp_select < date
    error = "カードの有効期限を選択してください" if (exp_year == "2019") && (exp_month == "1")
    return error
  end

  def check_cvc(cvc)
    return "セキュリティコードの桁数が違います" if (cvc.length < 3) || (cvc.length > 4)
    return "セキュリティコードは数字のみで入力してください" unless cvc.match(/[0-9]/)
  end

end
