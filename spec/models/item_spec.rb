require 'rails_helper'

RSpec.describe Item, type: :model do
  describe Item do
    before do
      @item = FactoryBot.build(:item)
    end

    before do
      @user = FactoryBot.build(:user)
    end

    describe '#update' do
      it "has a valid factory of item" do
        item = @item
        expect(item).to be_valid
      end

      it "has a valid factory of user" do
        user = @user
        expect(user).to be_valid
      end

      # 名前が空欄だとエラー
      it "is invalid without a name" do
        item = FactoryBot.build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end
      # 値段が空欄だとエラー
      it "is invalid without a price" do
        item = FactoryBot.build(:item, price: "")
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
      end

      # アイテムの名前をappleからbananaに変更
      it "is change from apple to banana" do
        item = @item
        expect{ item.update}.to change{ item.name}.from("apple").to("banana")
      end
    end

    describe '#destroy' do

      it "itemが正常に作成できているか"
        item = @item
        expect(item).to be_valid
      end

      it "投稿を削除する" do
        item = @item
        expect{ item.destroy}.to change{ ItemImage.count }.by{-1}
      end
    end
  end
end
