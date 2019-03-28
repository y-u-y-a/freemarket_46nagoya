class BrandsController < ApplicationController

  before_action :category_in_brand, only: :show

  def show
    # カテゴリーが選択される
    @category = Category.find(params[:id])
    # 中間テーブルから関連したものを抽出する(カテゴリーで検索)
    @categoryBrands = @category.category_brands
    # ブランドのイニシャルを抽出する
    @brands = Brand.where(id: @categoryBrands.brand_id)
  end
end
