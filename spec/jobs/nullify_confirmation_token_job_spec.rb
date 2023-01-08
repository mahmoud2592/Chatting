require 'rails_helper'


RSpec.describe NullifyConfirmationTokenJob, :type => :job do
  it "that account is charged" do
    user = create :user
    expect(user.reload.confirmation_token).not_to be_nil
    NullifyConfirmationTokenJob.perform_now(user.id)
    expect(user.reload.confirmation_token).to be_nil
  end
end
