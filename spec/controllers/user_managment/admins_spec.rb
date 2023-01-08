require 'rails_helper'

RSpec.describe UserManagment::AdminsController, type: :controller do
  it_behaves_like "Users controllers", :admin
end