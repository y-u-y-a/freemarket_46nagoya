class BrandsController < ApplicationController

  before_action :category_in_brand, only: :show
  before_action :set_search,        only: :show

  def show
    # カテゴリーが選択される
    @category = Category.find(params[:id])
    # カテゴリーが持つブランドのレコードを抽出
    @Brands = @category.brands
    # 取得したレコードからinitialカラムの中だけを取得して配列で返す
    @initials = @Brands.pluck(:initial).uniq
  end
end
