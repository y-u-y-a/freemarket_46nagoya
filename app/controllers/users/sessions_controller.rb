# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :customize_sign_in_params, only: [:create]

  protected

  def customize_sign_in_params
    devise_parameter_sanitizer.permit :sign_in, keys: [ :email, :password]
  end

  def check_captcha
    self.resource = resource_class.new sign_in_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
  end
end
