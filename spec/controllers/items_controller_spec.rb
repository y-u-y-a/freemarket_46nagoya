require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe "GET #index" do

    it "indexアクション内で定義したインスタンス変数が期待したものになるか？" do
      item = FactoryBot.create_list(:item, 4)
      # createなので、FactoryBotで定義したデータをtest環境データベースに3つ保存して、変数itemにも代入する
      lady_items = item.sort{ |a, b| b.created_at <=> a.created_at }
      # 擬似的にindexアクションを動かす
      get :index
      # assignsメソッドの引数はコントローラで定義した@lady_itemsを指す
      # matchの引数はこのエクスペクテーション内で定義した変数で、さっき保存されたデータを使ってデータが格納される
      expect(assigns(:lady_items)).to match(lady_items)
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
