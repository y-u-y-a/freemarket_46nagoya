# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  require 'payjp'
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  prepend_before_action :check_captcha, only: [:create, :credit]
  prepend_before_action :customize_sign_up_params, only: [:create, :credit]
  # before_action :set_payjp_user, only: [:credit]
  protect_from_forgery except: [ :card_create, :card_delete, :payment_method, :card_registration]

  def to_signup
  end

  def create
    session[:nickname] = params[:session][:nickname]
    session[:email] = params[:session][:email]
    session[:password] = params[:session][:password]
    session[:password_confirmation] = params[:session][:password_confirmation]

    @temporary = Temporary.create(
      nickname:              session[:nickname],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
    )
    session[:user_id] = @temporary.id
  end

  def profile
    session[:first_name] = params[:session][:first_name]
    session[:last_name] = params[:session][:last_name]
    session[:first_name_kana] = params[:session][:first_name_kana]
    session[:last_name_kana] = params[:session][:last_name_kana]
    session[:birth_year] = params[:session][:birth_year]
    session[:birth_month] = params[:session][:birth_month]
    session[:birth_day] = params[:session][:birth_day]

    @temporary = Temporary.find(session[:user_id]).update(
      first_name:       session[:first_name],
      last_name:        session[:last_name],
      first_name_kana:  session[:first_name_kana],
      last_name_kana:   session[:last_name_kana],
      birth_year:       session[:birth_year],
      birth_month:      session[:birth_month],
      birth_day:        session[:birth_day],
    )
  end

  def address
    session[:post_number] = params[:session][:post_number]
    session[:prefecture] = params[:session][:prefecture]
    session[:city] = params[:session][:city]
    session[:town] = params[:session][:town]
    session[:building] = params[:session][:building]
    session[:phone_number] = params[:session][:phone_number]

    @temporary = Temporary.find(session[:user_id]).update(
      post_number:   session[:post_number],
      prefecture_id: session[:prefecture],
      city:          session[:city],
      town:          session[:town],
      building:      session[:building],
      phone_number:  session[:phone_number],
    )
  end

  def credit
    session[:number] = params[:session][:number]
    session[:exp_month] = params[:session][:exp_month]
    session[:exp_year] = params[:session][:exp_year]
    session[:cvc] = params[:session][:cvc]

    # userの正規登録
    @user = User.new(
      nickname:              session[:nickname],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
    )
    @user.save
    sign_up(@user, current_user)
    if @user.save
      Temporary.find(session[:user_id]).destroy
    end

    # プロフィールの正規登録
    @profile = Profile.new(
      first_name:      session[:first_name],
      last_name:       session[:last_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana:  session[:last_name_kana],
      birth_year:      session[:birth_year],
      birth_month:     session[:birth_month],
      birth_day:       session[:birth_day],
      user_id:         @user.id
    )
    @profile.save

    # 住所の正規登録
    @address = Address.new(
      post_number:   session[:post_number],
      prefecture_id: session[:prefecture],
      city:          session[:city],
      town:          session[:town],
      building:      session[:building],
      phone_number:  session[:phone_number],
      user_id:       @user.id
    )
    @address.save

    # クレジットの正規登録
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    card = Payjp::Token.create({
      card: {
        number:        session[:number],
        cvc:           session[:cvc],
        exp_month:     session[:exp_month],
        exp_year:      session[:exp_year]
      }},
      {
        'X-Payjp-Direct-Token-Generate': 'true'
      }
    )
    #トークンとアドレスで顧客の生成
    customer = Payjp::Customer.create(
      email: session[:email],
      card:  card
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

  # def set_payjp_user
  #   @user = User.find(session[:user_id])
  #   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  # end
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
