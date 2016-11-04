require 'rails_helper'

RSpec.describe Post, type: :model do
  # => using the let method. we create  anew instance of the post class named post.
  # => let dynamically defines a method
  let (:post) { Post.create!(title: "New Post Title", body: "New Post Body") }

  # => test whether post has attributes named title and body. tests whether post will return a non-niul value when post.title and post.body are called
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
