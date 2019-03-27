class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def set_category
    @child_category = []
    @grand_child_category = []
    @category = Category.where(main_category_id: nil).where(sub_category_id: nil)
    i = 1 #レディース
    while i <= 14
      @child_category << Category.where(main_category_id: i).where(sub_category_id: nil)
      @child_category[i - 1].each do |cate|
        @grand_child_category << Category.where(main_category_id: i).where(sub_category_id: cate.id)
      end
      i += 1
    end
  end



  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  private
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
