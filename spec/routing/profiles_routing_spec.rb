require "rails_helper"

RSpec.describe UserManagment::ProfilesController, type: :routing do
  describe "routing" do


    it "routes to #show" do
      expect(get: "/myprofile").to route_to("user_managment/profiles#show")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/myprofile").to route_to("user_managment/profiles#update")
    end
  end
end
