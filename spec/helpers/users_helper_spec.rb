require 'rails_helper'

Specs in this file have access to a helper object that includes
the UsersHelper. For example:

describe UsersHelper do
  describe "string concat" do
    it "concats two strings with spaces" do
      expect(helper.concat_strings("this","that")).to eq("this that")
    end
  end
end
RSpec.describe UsersHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end


OmniAuth.config.test_mode = true

RSpec.configure do |config|
  # FactoryBotの記述省略
  config.include FactoryBot::Syntax::Methods
  # deviseで使うヘルパー
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
end
RSpec.configure do |config|
  config.include OmniauthMocks
end
