module ApplicationHelper
  def zip_code(zip)
    zip_code = zip.to_s
    zip_code.insert(3,"-")
  end
end
