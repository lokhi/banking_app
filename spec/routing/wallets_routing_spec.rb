require "rails_helper"

RSpec.describe V1::WalletsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/wallets").to route_to("v1/wallets#index")
    end
    it "routes to #create" do
      expect(post: "/v1/wallets").to route_to("v1/wallets#create")
    end

  end
end
