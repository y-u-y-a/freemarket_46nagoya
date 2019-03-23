require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  describe "#edit" do
    context "as an authorized user" do
      # 正常なレスポンスか？
      it "responds successfully" do
        sign_in @user
        get :edit, params: {id: @item.id}
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        sign_in @user
        get :edit, params: {id: @item.id}
        expect(response).to have_http_status "200"
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to_not be_success
      end
      # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
      it "redirects the page to root_path" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end
    end
    context "as a guest user" do
      # 302レスポンスが返ってきているか？
      it "returns a 302 response" do
        get :edit, params: {id: @item.id}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "#edit" do
    context "as an authorized user" do
      # 正常なレスポンスか？
      it "responds successfully" do
        sign_in @user
        get :edit, params: {id: @item.id}
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        sign_in @user
        get :edit, params: {id: @item.id}
        expect(response).to have_http_status "200"
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to_not be_success
      end
      # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
      it "redirects the page to root_path" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end
    end
    context "as a guest user" do
      # 302レスポンスが返ってきているか？
      it "returns a 302 response" do
        get :edit, params: {id: @item.id}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      # 正常に記事を更新できるか？
      it "updates an article" do
        sign_in @user
        item_params = {title: "うんこちゃん"}
        patch :update, params: {id: @item.id, item: item_params}
        expect(@item.reload.title).to eq "うんこちゃん"
      end
      # 記事を更新した後、更新された記事の詳細ページへリダイレクトするか？
      it "redirects the page to /items/article.id(1)" do
        sign_in @user
        item_params = {title: "うんこちゃん"}
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to redirect_to "/items/1"
      end
    end
    context "with invalid attributes" do
      # 不正なアトリビュートを含む記事は更新できなくなっているか？
      it "does not update an article" do
        sign_in @user
        item_params = {title: nil}
        patch :update, params: {id: @item.id, item: item_params}
        expect(@item.reload.title).to eq "加藤純一"
      end
      # 不正な記事を更新しようとすると、再度更新ページへリダイレクトされるか？
      it "redirects the page to /items/article.id(1)/edit" do
        sign_in @user
        item_params = {title: nil}
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to redirect_to "/items/1/edit"
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to_not be_success
      end
      # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
      it "redirects the page to root_path" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end
    end
    context "as a guest user" do
      # 302レスポンスを返すか？
      it "returns a 302 response" do
        item_params = {
          title: "加藤純一",
          text: "加藤純一？　神",
          user_id: 1
        }
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        item_params = {
          title: "加藤純一",
          text: "加藤純一？　神",
          user_id: 1
        }
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  # describe Item do
  #   before do
  #     @item = FactoryBot.build(:item)
  #   end

  #   before do
  #     @user = FactoryBot.build(:user)
  #   end

  #   describe '#update' do
  #     it "has a valid factory of item" do

  #       @user = FactoryBot.build(:user)
  #       @item = FactoryBot.build(:item)

  #       patch :update, params: {id: @user.id}
  #       expect(@item).to be_valid
  #     end
  #   end

    #   it "has a valid factory of user" do
    #     user = @user
    #     expect(user).to be_valid
    #   end

    #   # 名前が空欄だとエラー
    #   it "is invalid without a name" do
    #     item = FactoryBot.build(:item, name: "")
    #     item.valid?
    #     expect(item.errors[:name]).to include("can't be blank")
    #   end
    #   # 値段が空欄だとエラー
    #   it "is invalid without a price" do
    #     item = FactoryBot.build(:item, price: "")
    #     item.valid?
    #     expect(item.errors[:price]).to include("can't be blank")
    #   end

    #   # アイテムの名前をappleからbananaに変更
    #   it "is change from apple to banana" do
    #     item = @item
    #     expect{ item.update}.to change{ item.name}.from("apple").to("banana")
    #   end
    # end

    # describe '#destroy' do
    #   it "itemが正常に作成できているか" do
    #     item = @item
    #     expect(item).to be_valid
    #   end
    #   it "投稿を削除する" do
    #     item = @item
    #     expect{ item.destroy}.to change{ ItemImage.count }.by{-1}
    #   end
    # end
  # end
end
