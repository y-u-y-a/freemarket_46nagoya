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

  describe "POST #create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "renders the :show template" do
      get :show, params: { id: 1 }
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "assigns the requested item to @item" do
      item = create(:item)
      get :edit, params: { id: item}
      expect(assigns(:item)).to eq item
    end
    it "renders the :edit template" do
    end
  end

  describe 'DELETE #destroy' do
    let(:item) { FactoryBot.build(:item) }
    it "itemが正常に作成できているかどうか" do
      expect(item).to be_valid
    end

    it "deletes the item" do
      expect{
        delete :destroy, id: item
      }.to change(Item,:count).by(-1)
    end
  end
end
