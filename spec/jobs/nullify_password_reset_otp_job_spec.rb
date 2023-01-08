require 'rails_helper'


RSpec.describe NullifyResetPasswordOtpJob, :type => :job do
  it "that account is charged" do
    user = create :user
    user.set_reset_password_otp
    expect(user.reload.reset_password_otp).not_to be_nil
    NullifyResetPasswordOtpJob.perform_now(user.id)
    expect(user.reload.reset_password_otp).to be_nil
  end
end
