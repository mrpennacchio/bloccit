require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  # => create a parent topic for post
  let(:topic) { Topic.create!(name: name, description: description) }
  # => associate post with topic via topic.posts.create! this creates a post for a given topic
  let (:post) { topic.posts.create!(title: title, body: body) }

  # => test whether post has attributes named title and body. tests whether post will return a non-niul value when post.title and post.body are called
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: title, body: body)
    end
  end
end
