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
