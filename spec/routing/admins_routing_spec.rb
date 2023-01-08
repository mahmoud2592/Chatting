require "rails_helper"

RSpec.describe UserManagment::BrokersController, type: :routing do
  it_behaves_like "users routing", :admins

end
