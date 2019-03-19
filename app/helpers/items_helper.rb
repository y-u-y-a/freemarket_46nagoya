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
end
