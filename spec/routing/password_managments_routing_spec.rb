require "rails_helper"

RSpec.describe UserManagment::PasswordManagmentsController, type: :routing do
  describe "routing" do
    it "routes to #reset_password" do
      expect(post: "/reset_password").to route_to("user_managment/password_managments#reset_password")
    end
    it "routes to #/set_password" do
      expect(post: "/set_password").to route_to("user_managment/password_managments#set_new_password")
    end
    it "routes to #/forgot_password" do
      expect(post: "/forgot_password").to route_to("user_managment/password_managments#forgot_password")
    end    
    it "routes to #/verify_otp" do
      expect(post: "/verify_otp").to route_to("user_managment/password_managments#verify_otp")
    end
  end
end
