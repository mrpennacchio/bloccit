require 'rails_helper'

RSpec.describe Vote, type: :model do
  let (:topic) { create(:topic) }
  let (:user) { create(:user) }
  let (:post) { create(:post) }
  let (:vote) { create(:vote, post: post, user: user) }

  # test that votes belong to posts and users
  it { is_expected.to belong_to (:post) }
  it { is_expected.to belong_to (:user) }
  # test that value is present when votes are created
  it { is_expected.to validate_presence_of(:value) }
  # validate that value is either -1(down vote) or 1 (up vote)
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }

  describe "update_post callback" do
    it "triggers update_post on save" do
      # we expect update_post_rank to be called on vote after it's saved
      expect(vote).to receive(:update_post).at_least(:once)
      vote.save!
    end

    it "#update_post should call update_rank on post " do
      # expect that vote's post will recieve a call to update_rank
      expect(post).to receive(:update_rank).at_least(:once)
      vote.save!
    end
  end
end
