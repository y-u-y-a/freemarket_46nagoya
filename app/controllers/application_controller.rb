class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def set_category
    @child_category = []
    @category = Category.where(main_category_id: nil).where(sub_category_id: nil)
    @category.each do |category|
      @child_category << Category.where(main_category_id: category.id).where(sub_category_id: nil)
    end
  end

  def category_in_brand
    @categories = Category.find(1,2,3,4,490,334,7,681,9,899,1235,738,1207,1272,1200,1201)
  end

  def set_price
    @price = Item.where(user_id: current_user&.id).where(business_stats: 3)
    @total_price = @price.sum(:price)
  end

  def set_late_count
    item = Item.find(params[:id])
    @good = Late.where(late_user: item.user.id).where(late: 1)
    @good_count = @good.length
    @normal = Late.where(late_user: item.user.id).where(late: 2)
    @normal_count = @normal.length
    @bad = Late.where(late_user: item.user.id).where(late: 3)
    @bad_count = @bad.length
  end

  def user_late_count
    user = User.find(params[:id])
    @good = Late.where(late_user: user.id).where(late: 1)
    @good_count = @good.length
    @normal = Late.where(late_user: user.id).where(late: 2)
    @normal_count = @normal.length
    @bad = Late.where(late_user: user.id).where(late: 3)
    @bad_count = @bad.length
  end

  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  def set_search
    @search = Item.ransack(params[:q]) #ransackメソッド推奨
    @search_items = @search.result(distinct: true).page(params[:page]).per(8).order(id: "DESC")
  end

  def set_searches
    brand_id = Brand.find_by(name: params[:q][:brand_id_eq])
    params[:q][:brand_id_eq] = brand_id.id if brand_id.present?
    if params[:q]["price_cont"] != "0"
      params[:q]["price_gteq_any"] = set_price_gteq(params[:q]["price_cont"])
      params[:q]["price_lteq_any"] = set_price_lteq(params[:q]["price_cont"])
    end
    params[:q]["price_cont"]     = ""
    params[:q]["s"]["0"]["name"] = set_sort_name(params[:q]["id"]) if params[:q]["id"] != nil
    params[:q]["s"]["0"]["dir"]  = set_sort_dir(params[:q]["id"]) if params[:q]["id"] != nil

    @searches = Item.ransack(params[:q]) #ransackメソッド推奨
    @search_items = @searches.result(distinct: true).page(params[:page]).per(8).order(id: "DESC")
    @searches.build_sort if @searches.sorts.empty?
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

  def set_price_gteq(search_select)
    case search_select
    when "1" then
      return "300"
    when "2" then
      return "1000"
    when "3" then
      return "5000"
    when "4" then
      return "10000"
    when "5" then
      return "30000"
    when "6" then
      return "50000"
    end
  end

  def set_price_lteq(search_select)
    case search_select
    when "1" then
      return "1000"
    when "2" then
      return "5000"
    when "3" then
      return "10000"
    when "4" then
      return "30000"
    when "5" then
      return "50000"
    end
  end

  def set_sort_name(sort_select)
    case sort_select
    when "1" , "2" then
      return "price"
    when "3" , "4" then
      return "created_at"
    when "5" then
      return "likes_count"
    end
  end

  def set_sort_dir(sort_select)
    case sort_select
    when "1" , "3" then
      return "asc"
    when "2" , "4" , "5" then
      return "desc"
    end
  end

end
