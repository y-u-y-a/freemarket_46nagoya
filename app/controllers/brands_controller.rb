class BrandsController < ApplicationController

  before_action :category_in_brand, only: [:show, :brand_show]
  before_action :set_search,        only: [:show, :brand_show]
  before_action :set_category,      only: [:show, :brand_show]

  def show
    @category_index = Category.find(params[:id])
    @brands = @category_index.brands
    @initials = @brands.pluck(:initial).uniq
  end

  def brand_show
    @brand = Brand.find(params[:id])
    @items = @brand.items
  end
end
