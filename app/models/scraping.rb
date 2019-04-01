class Scraping

  require 'nokogiri'
  require 'open-uri'

  def self.category
    url = 'https://www.mercari.com/jp/category/'
    doc = Nokogiri::HTML(open(url))
    category = doc.search(".category-list-individual-box-root-category-name h3")
    category.each do |cate|
      name = cate.inner_text
      get_category(name, nil, nil, 1)
    end
    i = 1 #レディース
    while i <= 14
      i2 = 3
      category2 = doc.search(".category-list-box div:nth-child(#{i}) div:nth-child(2) .category-list-individual-box-sub-category-name h4")
      category2.each do |cate|
        name = cate.inner_text
        get_category(name, i, nil, 2)
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
      get_category(name, i, categoryid, 3) if name.include?('すべて') != true
    end
  end
  def self.get_category(name, main, sub, depth)
    category = Category.new
    category.main_category_id = main
    category.sub_category_id = sub
    category.name = name
    category.depth = depth
    category.save
  end


  # brand一覧のスクレイピング
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
          name = name.gsub(/\n|\s/, "")
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
    CategoryBrand.create(category_id: num, brand_id: brand.id)
  end


  # brandのイントロを取得する
  def self.brand_intro
    agent = Mechanize.new
    page = 1
    while page < 11000 do
      # 普通の処理
      begin
        doc = agent.get("https://www.mercari.com/jp/brand/#{page}/")
      # エラーが出た場合に実行する処理(例外処理)
      rescue Mechanize::ResponseCodeError => e
        case e.response_code
        when "404"
          puts "caught Net::HTTPNotFound !"
          page += 1
          next
        end
      end
      # titleを取得する
      title = doc.search(".spacial-description-title h3")
      # 正規表現されている部分は取り除く
      title = title.inner_text.gsub(/\n|\s/, "")
      # introを取得する
      ele = doc.search(".spacial-description-text p")
      intro = ele.inner_text
      # nameカラムがtitleと一致するレコードを全て取得する
      select_brand = Brand.where(name: title)
      # レコードを更新する
      select_brand.update(intro: intro)
      page += 1
    end
  end



  # categoryのイントロを取得する
  def self.intro_urls
    agent = Mechanize.new

    i = 1

    while true do
      begin
        current_page = agent.get("https://www.mercari.com/jp/category/#{i}/")
      rescue Mechanize::ResponseCodeError => e
        case e.response_code
        when "404"
          puts "caught Net::HTTPNotFound !"
          i += 1
          next # ページが見付からないときは次へ
        end
      end

      category_name = current_page.at(".bread-crumbs li:nth-child(3) a span")

      category_name = current_page.at(".bread-crumbs li:nth-child(3) span") if category_name == nil

      child_category_name = current_page.at(".bread-crumbs li:nth-child(4) a span")

      child_category_name = current_page.at(".bread-crumbs li:nth-child(4) span") if child_category_name == nil

      grand_child_category_name = current_page.at(".bread-crumbs li:nth-child(5) a span")

      grand_child_category_name = current_page.at(".bread-crumbs li:nth-child(5) span") if grand_child_category_name == nil


      if child_category_name.nil? && grand_child_category_name.nil?
        main_category_id = get_parent(category_name)

        intro = current_page.at(".spacial-description-text p")

        update_category(main_category_id, intro) if intro.present?

      elsif child_category_name.present? && grand_child_category_name.nil?
        main_category_id = get_parent(category_name)

        child_category_id = get_child(main_category_id, child_category_name)

        intro = current_page.at(".spacial-description-text p")

        child_category_id.each do |child|
          update_category(child, intro) if intro.present?
        end

      elsif child_category_name.present? && grand_child_category_name.present?
        main_category_id = get_parent(category_name)

        child_category_id = get_child(main_category_id, child_category_name)

        grand_child_category_id = get_grand_child(main_category_id, child_category_id, grand_child_category_name)

        intro = current_page.at(".spacial-description-text p")

        grand_child_category_id.each do |grand|
          update_category(grand, intro)
        end

      end

      i += 1

      break if break_check == true

    end
  end

  def self.break_check
    intro = Category.where(intro: nil)
    return true if intro.nil?
  end

  def self.get_parent(category)
    main_category_id = []
    cate_name = category.inner_text
    target = Category.find_by(name: cate_name)
    main_category_id = target.id if target.present?

    return main_category_id
  end

  def self.get_child(category, child_category)
    child_category_id = []
    child_cate_name = child_category.inner_text
    target = Category.where(name: child_cate_name).where(main_category_id: category)
    target.each do |tage|
      child_category_id << tage.id
    end

    return child_category_id
  end

  def self.get_grand_child(category, child_category, grand_child_category)
    grand_child_category_id = []
    grand_child_cate_name = grand_child_category.inner_text
    target = Category.where(name: grand_child_cate_name).where(main_category_id: category).where(sub_category_id: child_category)
    target.each do |tage|
      grand_child_category_id << tage.id
    end

    return grand_child_category_id
  end

  def self.update_category(id, intro)
    intro = intro.inner_text
    category = Category.find(id)
    category.intro = intro
    category.save
  end
end
