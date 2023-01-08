require 'rails_helper'
require_relative '../../support/session_spec_helper'
include SessionSpecHelper
describe UserManagment::AdminPolicy do
    subject { described_class.new(user, admin) }
    let(:admin) { FactoryBot.create :admin }
    
  context 'user' do
    policies_login_as [:broker, :farmer, :service_provider, :merchant].sample
    it { is_expected.to forbid_action(:create) }
    # it { is_expected.to forbid_action(:destroy) }
  end


  context 'admin' do
    policies_login_as :admin
 
    it { is_expected.to permit_action(:create) }
  end
end