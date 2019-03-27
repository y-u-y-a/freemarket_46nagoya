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

  # categoriesテーブルに取得した値を保存
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

  # レディースのbrand一覧のスクレイピング
  def self.brand
    urls = [
      # レディース1
      'https://www.mercari.com/jp/brand/?brand_group_id=1',
      # メンズ2
      'https://www.mercari.com/jp/brand/?brand_group_id=2',
      # キッズ3
      'https://www.mercari.com/jp/brand/?brand_group_id=3',
      # インテリア4
      'https://www.mercari.com/jp/brand/?brand_group_id=4',
      # キッチン490
      'https://www.mercari.com/jp/brand/?brand_group_id=5',
      # 時計メンズ334レディース167
      'https://www.mercari.com/jp/brand/?brand_group_id=6',
      # コスメ7
      'https://www.mercari.com/jp/brand/?brand_group_id=7',
      # テレビゲーム681
      'https://www.mercari.com/jp/brand/?brand_group_id=8',
      # スポーツ9
      'https://www.mercari.com/jp/brand/?brand_group_id=10',
      # スマートホン899
      'https://www.mercari.com/jp/brand/?brand_group_id=11',
      # バイク1235
      'https://www.mercari.com/jp/brand/?brand_group_id=12',
      # 楽器738
      'https://www.mercari.com/jp/brand/?brand_group_id=13',
      # 自動車パーツ1207
      'https://www.mercari.com/jp/brand/?brand_group_id=14',
      # 食品1272
      'https://www.mercari.com/jp/brand/?brand_group_id=15',
      # 国内自動車本体1200
      'https://www.mercari.com/jp/brand/?brand_group_id=16',
      # 外国自動車本体1201
      'https://www.mercari.com/jp/brand/?brand_group_id=17'
    ]


    urls.each_with_index do |url, index|
      doc = Nokogiri::HTML(open(url))
      # イニシャルの入った要素を配列で抜き出す
      initials = doc.search(".brand-list-initial-box-initial h4")
      # イニシャルの入った要素1つを抜き指す
      initials.each do |ini|
        # イニシャルを変数に入れる
        initial = ini.inner_text
        # そのイニシャル内のブランド名の入った要素を抜きだす
        brands = doc.search("#initial-#{initial} .brand-list-initial-box-brand-list a .brand-list-initial-box-brand-name div p")
        # 配列urlのindexを指す,category_idに入れる数字を指定するため
        if index == 0
          num = 1
        elsif index == 1
          num = 2
        elsif index == 2
          num = 3
        elsif index == 3
          num = 4
        elsif index == 4
          num = 490
        elsif index == 5
          num = 334
        elsif index == 6
          num = 7
        elsif index == 7
          num = 681
        elsif index == 8
          num = 9
        elsif index == 9
          num = 899
        elsif index == 10
          num = 1235
        elsif index == 11
          num = 738
        elsif index == 12
          num = 1207
        elsif index == 13
          num = 1272
        elsif index == 14
          num = 1200
        elsif index == 15
          num = 1201
        end
        brands.each do |brand|
          name = brand.inner_text
          get_brand(initial,name,num)
        end
      end
    end
  end

  def self.get_brand(initial,name,num)
    brand = Brand.new
    brand.initial = initial
    brand.name = name
    brand.save
    CategoryBrand.create(category_id: num, brand_id: brand.id,)
  end
end
