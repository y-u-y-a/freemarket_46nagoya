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

  def category_in_brand
    @categories = Category.find(1,2,3,4,490,334,7,681,9,899,1235,738,1207,1272,1200,1201)
  end



  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  def set_search
    @search = Item.ransack(params[:q]) #ransackメソッド推奨
    @search_items = @search.result(distinct: true).page(params[:page]).per(8)
  end

  def set_searches
    params[:q]["price_gteq_any"] = set_price_gteq(params[:q]["price_cont"]) if params[:q]["price_cont"] != nil
    params[:q]["price_lteq_any"] = set_price_lteq(params[:q]["price_cont"]) if params[:q]["price_cont"] != nil
    params[:q]["price_cont"]     = ""
    params[:q]["s"]["0"]["name"] = set_sort_name(params[:q]["id"]) if params[:q]["id"] != nil
    params[:q]["s"]["0"]["dir"]  = set_sort_dir(params[:q]["id"]) if params[:q]["id"] != nil

    @searches = Item.ransack(params[:q]) #ransackメソッド推奨
    @search_items = @searches.result(distinct: true).page(params[:page]).per(8)
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
