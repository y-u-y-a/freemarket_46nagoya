class Scraping

  require 'nokogiri'
  require 'open-uri'

  def self.category

    url = 'https://www.mercari.com/jp/category/'
    doc = Nokogiri::HTML(open(url))

    category = doc.search(".category-list-individual-box-root-category-name h3")

    category.each do |cate|
      name = cate.inner_text
      get_category(name, nil, nil, 0, 0, 1)
    end

    i = 1 #レディース

    while i <= 14
      i2 = 3

      category2 = doc.search(".category-list-box div:nth-child(#{i}) div:nth-child(2) .category-list-individual-box-sub-category-name h4")
      category2.each do |cate|
        name = cate.inner_text
        get_category(name, i, nil, 0, 0, 2)

        categoryid = Category.last
        categoryid = categoryid.id

        get_category3(i, i2, categoryid, doc)

        i2 += 2
      end

      i += 1
    end
  end

  def self.get_category3(i, i2, categoryid, doc)

    category3 = doc.search(".category-list-box div:nth-child(#{i}) div:nth-child(2) div:nth-child(#{i2}) div p a")

    category3.each do |cate|
      name = cate.inner_text
      name = name.gsub(/\r\n|\r|\n|\s|\t/, "")
      get_category(name, i, categoryid, 0, 0, 3) if name.include?('すべて') != true
    end
  end

  def self.get_category(name, main, sub, size, brand, depth)
    category = Category.new
    category.main_category_id = main
    category.sub_category_id = sub
    category.size = size
    category.brand = brand
    category.name = name
    category.depth = depth
    category.save
  end
end
