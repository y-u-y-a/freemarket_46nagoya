RSpec.describe AuthenticationsController, type: :controller do
  before { request.env["omniauth.auth"] = facebook_mock }
  subject { get :create, params: { provider: "facebook" } }

  it "oauthが渡ってこない場合エラーになる" do
    request.env["omniauth.auth"] = nil
    expect { subject }.to raise_error("request.env[omniauth.auth]がありません")
  end

  context "emailがある場合" do
    it "新規作成" do
      expect { subject }.to change { User.count }.from(0).to(1)
      expect { subject }.to change { SocialProfile.count }.from(0).to(1)
      expect(subject).to redirect_to edit_user_registration_url
    end
  end

  context "emailがない場合" do
    it "登録画面へリダイレクト" do
      request.env["omniauth.auth"]["info"]["email"] = nil
      expect(subject).to redirect_to new_user_registration_path
    end
  end
end
