shared_examples "Users controllers" do |model|

  describe "User registeration" do
    it "should pass and return created" do
      post :create, :params => { model => FactoryBot.attributes_for(:user) }, as: :json
      expect(response.status).to eq(201)
      expect(response.content_type).to include "application/json"
    end

    it "should reject request due to unproccessible entities" do
      post :create, :params => { model => { :mobile => "+966155554444"} }, as: :json
      expect(response.status).to eq(422)
    end
  end
  

end
