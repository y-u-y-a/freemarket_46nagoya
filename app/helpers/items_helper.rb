module ItemsHelper

  def converting_to_yenSign(price)
    "¥#{price.to_s(:delimited, delimiter: ',')}"
  end
end
