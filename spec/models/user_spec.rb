require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe User do
  describe '#create' do

    # nickname,email,password,password_confirmationカラムが全てのバリデーションをクリアするか？
    it "is valid with a nickname, avatar, profile_text, mail, password, password_confirmation" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    # nicknameカラムが空だとエラーが出るか？
    it "is invalid without a nickname" do
      user = FactoryBot.build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # emailカラムが空だとエラーが出るか？
    it "is invalid without a email" do
      user = FactoryBot.build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # passwordカラムが空だとエラーが出るか？
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # password_confirmationカラムがpasswordカラムと一致しないとエラーが出るか？
    it "is invalid without a password_coonfirmation" do
      user = FactoryBot.build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # emailカラムが重複するとエラーが出るか？
    it "is invalid with a duplicate email" do
      user = FactoryBot.create(:user)       # userを一人作成、データベースに保存
      another_user = FactoryBot.build(:user)# 同じuserを作成
      another_user.valid?        # バリデーションにより保存できる状態か？
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # passwordが7文字以下だとエラーが出るか？
    it "is invalid with a password that has less than 5 characters " do
      user = FactoryBot.build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short (minimum is 6 characters)")
    end

    # passwordが8文字以上だと有効になるか？
    it "is invalid a password that has more than 6 characters" do
      user = FactoryBot.build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user).to be_valid
    end

  end
end

