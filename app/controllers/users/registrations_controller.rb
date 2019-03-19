# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :customize_sign_up_params, only: [:create]

  # def new
  #   build_resource({})
  #   resource.build_profile
  #   respond_with self.resource
  # end

  # devise内製の処理＋profilesテーブルに保存する処理
  def create
    super
    # resource.build_profile
    # resource.profile = params[profiles_attributes: [:first_name,:user_id]]
    # resource.profile.save
    Profile.create(user_profiles_params)
  end


  private
  # デフォルトのキーのストロングパラメーター化
  def customize_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me])
  end

  # profilesテーブルのみのキーのストロングパラメータ化
  def user_profiles_params
    params.require(:user).permit(profiles_attributes: [:id, :first_name, :last_name, :first_name_kana, :last_name_kana, :user_id])
  end

  #  全てをまとめた
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up) do |params|
  #     params.require(:user).permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me, :nickname, profile_attributes: [:first_name, :last_name, :first_name_kana, :last_name_kana]])
  #   end
  # end


  def check_captcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
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
