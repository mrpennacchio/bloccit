require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  # => create a parent topic for post
  let(:topic) { Topic.create!(name: name, description: description) }
  # => associate post with topic via topic.posts.create! this creates a post for a given topic

  # create a user to associate with test post
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  # associate user with post when we create the test post
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }
  # => test whether post has attributes named title and body. tests whether post will return a non-niul value when post.title and post.body are called

  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  it{ is_expected.to validate_length_of(:title).is_at_least(5) }
  it{ is_expected.to validate_length_of(:body).is_at_least(20) }


  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end

  describe "voting" do
    # create three up votes and two down before each spec
    before do
      3.times { post.votes.create!(value: 1, user: user) }
      2.times { post.votes.create!(value: -1, user: user ) }
      @up_votes = post.votes.where(value: 1 ).count
      @down_votes = post.votes.where(value: -1).count
    end

    # test that upvotes returns count of up votes
    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect( post.up_votes ).to eq(@up_votes)
      end
    end

    # test that downvotes returns the downvote count
    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect( post.down_votes ).to eq(@down_votes)
      end
    end
    # test that points returns the sum of all votes on the post
    describe "#points" do
      it "returns the sum of all down and up votes" do
        expect( post.points ).to eq(@up_votes - @down_votes)
      end
    end

    describe "#update_rank" do
      # expect that a posts rank will be determined by the following:
      it "calculates the correct rank" do
        post.update_rank
        # determine age of post by subtracting standard time from created_at time
        expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end

      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1, user: user)
        expect(post.rank).to eq (old_rank + 1)
      end

      it "updates when a down vote is created" do
        old_rank = post.rank
        post.votes.create!(value: -1, user: user)
        expect(post.rank).to eq (old_rank - 1)
      end
    end
  end
end
