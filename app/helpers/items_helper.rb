module ItemsHelper

  def thousands_separator(price)
    "#{price.to_s(:delimited, delimiter: ',')}"
  end

  def commission(price)
    @commission = (price * 0.1).round()
  end

  def profits(price)
    profits = (price - @commission)
  end

  def get_child_category(category)
    @child_category = Category.where(main_category_id: category.id).where(sub_category_id: nil)
  end

  def get_grand_child_category(category, child_category)
    @grand_child_category = Category.where(main_category_id: category.id).where(sub_category_id: child_category.id)
  end

end
