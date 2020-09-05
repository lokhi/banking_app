require "rails_helper"

RSpec.describe V1::CardsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/cards").to route_to("v1/cards#index")
    end

    it "routes to #create" do
      expect(post: "/v1/cards").to route_to("v1/cards#create")
    end

  end
end
