require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe "GET #index" do

    it "indexアクション内で定義したインスタンス変数が期待したものになるか？" do
      # createなので、FactoryBotで定義したデータをtest環境データベースに3つ保存して、変数itemにも代入する
      items = []
      items = FactoryBot.create_list(:items, 100)
      # lady_items = items.where(category_id: "1").first(4)
      get :index
      # assignsメソッドの引数はFactoryBotで定義している変数を指す
      #matchの引数はこのエクスペクテーション内で定義した変数で、さっき保存されたデータを使ってデータが格納される
      expect(assigns(:items)).to match(items.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
