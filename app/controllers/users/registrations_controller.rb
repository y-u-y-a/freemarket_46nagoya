# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  require "payjp"
  require "date"
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_user!,expect: :credit

  prepend_before_action :check_captcha, only: [:create, :credit]
  prepend_before_action :customize_sign_up_params, only: [:create, :credit]
  protect_from_forgery except: [ :card_create, :card_delete, :payment_method, :card_registration]

  def to_signup
  end

  def create
    check = true

    session[:nickname]              = params[:session][:nickname]
    session[:email]                 = params[:session][:email]
    session[:password]              = params[:session][:password]
    session[:password_confirmation] = params[:session][:password_confirmation]

    @temporary = Temporary.create(
      nickname:              session[:nickname],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
    )

    @error = []
    @error << check_name(session[:nickname])
    @error << check_email(session[:email])
    @error = @error.compact

    check = @temporary.save(context: :new_user)

    if (check == false) || (@error.empty? == false) then
      @temporary.destroy
      render :new
    end

    session[:user_id] = @temporary.id
  end

  def profile

    session[:first_name]      = params[:session][:first_name]
    session[:last_name]       = params[:session][:last_name]
    session[:first_name_kana] = params[:session][:first_name_kana]
    session[:last_name_kana]  = params[:session][:last_name_kana]
    session[:birth_year]      = params[:session][:birth_year]
    session[:birth_month]     = params[:session][:birth_month]
    session[:birth_day]       = params[:session][:birth_day]

    @temporary = Temporary.find(session[:user_id])

    @temporary.update(
      first_name:       session[:first_name],
      last_name:        session[:last_name],
      first_name_kana:  session[:first_name_kana],
      last_name_kana:   session[:last_name_kana],
      birth_year:       session[:birth_year],
      birth_month:      session[:birth_month],
      birth_day:        session[:birth_day],
    )

    render :create unless @temporary.save(context: :profile_form)

  end

  def address
    check = true

    session[:post_number]   = params[:session][:post_number]
    session[:prefecture_id] = params[:session][:prefecture_id]
    session[:city]          = params[:session][:city]
    session[:town]          = params[:session][:town]
    session[:building]      = params[:session][:building]
    session[:phone_number]  = params[:session][:phone_number]

    @error = []
    @error << check_phone(session[:phone_number])
    @error = @error.compact

    @temporary = Temporary.find(session[:user_id])

    @temporary.update(
      post_number:   session[:post_number],
      prefecture_id: session[:prefecture_id],
      city:          session[:city],
      town:          session[:town],
      building:      session[:building],
      phone_number:  session[:phone_number],
    )

    check = @temporary.save(context: :address_form)

    if (check == false) || (@error.empty? == false) then
      @temporary.phone_number = nil
      @temporary.save
      render :profile
    end
  end

  def credit
    check = true

    session[:number]    = params[:session][:number]
    session[:exp_month] = params[:session][:exp_month]
    session[:exp_year]  = params[:session][:exp_year]
    session[:cvc]       = params[:session][:cvc]

    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    begin
      Payjp::Token.create({
        card: {
          number: session[:number],
          cvc: session[:cvc],
          exp_month: session[:exp_month],
          exp_year: session[:exp_year]
        }},
        {
          "X-Payjp-Direct-Token-Generate": "true"
        })
    rescue
      check = false
      @error = []
      @error << "カードの登録に失敗しました"
      @error << check_number(session[:number])
      @error << check_select(session[:exp_year], session[:exp_month])
      @error << check_cvc(session[:cvc])
      @error = @error.compact
    end

    if check == true
      card = Payjp::Token.create({
        card: {
          number: session[:number],
          cvc: session[:cvc],
          exp_month: session[:exp_month],
          exp_year: session[:exp_year]
        }},
        {
          "X-Payjp-Direct-Token-Generate": "true"
        })
      customer = Payjp::Customer.create(
        email: session[:email],
        card: card
        )
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
        prefecture_id: session[:prefecture_id],
        city:          session[:city],
        town:          session[:town],
        building:      session[:building],
        phone_number:  session[:phone_number],
        user_id:       @user.id
      )
      @address.save

      @user.update_attribute(:customer_id, customer.id)
    else
      render :address
    end
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

  def check_name(nickname)
    nickname = User.where(nickname: nickname)
    return "このニックネームは使われています" if nickname.present?
  end

  def check_email(email)
    email    = User.where(email: email)
    return "このE-MAILは使われています" if email.present?
  end

  def check_phone(phone)
    phone = Address.where(phone_number: phone)
    return "この電話番号は使われています" if phone.present?
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
  end

end
