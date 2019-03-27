class CategoriesController < ApplicationController
  before_action :set_category_show, only: :show
  before_action :set_search
  before_action :set_category

  def show
    if @show_category.main_category_id.nil? && @show_category.sub_category_id.nil? #親カテゴリだった場合
      child_category
      @items = Item.where(category_id: @show_category.id).page(params[:page]).per(4).order(id: "DESC")
    elsif @show_category.main_category_id.present? && @show_category.sub_category_id.nil? #サブカテゴリだったら
      grand_child_category
      @items = Item.where(child_category_id: @show_category.id).page(params[:page]).per(4).order(id: "DESC")
    else
      @items = Item.where(grand_child_category_id: @show_category.id).page(params[:page]).per(4).order(id: "DESC")
    end
  end

  def child_category
    @page = "main"
    @child_category_names = Category.where(main_category_id: @show_category.id).where(sub_category_id: nil).where.not(name: "その他")
  end

  def grand_child_category
    @page = "sub"
    @grand_child_category_names = Category.where(sub_category_id: @show_category.id).where.not(name: "その他")
  end

  private

  def set_category_show
    @show_category = Category.find(params[:id])
  end

end
