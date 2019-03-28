# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  require 'payjp'
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :customize_sign_up_params, only: [:create]
  before_action :set_payjp_user, only: [:credit]
  protect_from_forgery :except => [ :card_create, :card_delete, :payment_method, :card_registration]

  def to_signup
  end

  def create
    super
    session[:user_id] = resource.id
  end

  def phone_number
    # profilesテーブル
    session[:first_name] = params[:session][:first_name]
    session[:last_name] = params[:session][:last_name]
    session[:first_name_kana] = params[:session][:first_name_kana]
    session[:last_name_kana] = params[:session][:last_name_kana]
    session[:birth_year] = params[:session][:birth_year]
    session[:birth_month] = params[:session][:birth_month]
    session[:birth_day] = params[:session][:birth_day]
    # テーブルに保存する処理
    @profile = Profile.new(
      first_name: session[:first_name],
      last_name: session[:last_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      user_id: session[:user_id]
      )
    @profile.save
  end

  def address
    # sessionに住所を格納する処理
    session[:post_number] = params[:session][:post_number]
    session[:prefecture] = params[:session][:prefecture]
    session[:city] = params[:session][:city]
    session[:town] = params[:session][:town]
    session[:building] = params[:session][:building]
    # テーブルに保存する処理
    @address = Address.new(
      post_number: session[:post_number],
      prefecture_id: session[:prefecture],
      city: session[:city],
      town: session[:town],
      building: session[:building],
      phone_number: session[:phone_number],
      user_id: session[:user_id]
    )
    @address.save
  end

  def credit
    # sessionに情報を格納する処理
    session[:number] = params[:session][:number]
    session[:exp_month] = params[:session][:exp_month]
    session[:exp_year] = params[:session][:exp_year]
    session[:cvc] = params[:session][:cvc]
    # # カードのトークン生成
    card = Payjp::Token.create({
      card: {
        number: session[:number],
        exp_month: session[:exp_month],
        exp_year: session[:exp_year],
        cvc: session[:cvc]
      }
    })
    #トークンとアドレスで顧客の生成
    customer = Payjp::Customer.create(
      email: @user.email,
      card: card
    )
    # 顧客とユーザーの紐付け
    @user.update_attribute(:customer_id, customer.id)
  end


  protected

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:nickname, :email, :password, :password_confirmation, :remember_me]
  end

  def check_captcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
  end

  def set_payjp_user
    @user = User.find(current_user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end
end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
