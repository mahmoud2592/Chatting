shared_examples "users routing" do |model|

  describe "routing" do

    it "routes to #create" do
      expect(post: "/#{model}/register").to route_to("user_managment/#{model}#create")
    end

  end
end