require 'rails_helper'


RSpec.describe ExpireUserStoryJob, :type => :job do
  it "that account is charged" do
    story = FactoryBot.create :story
    expect(story.reload.status).to eq("running")
    ExpireUserStoryJob.perform_now(story.id)
    expect(story.reload.status).to eq("expired")
  end
end
