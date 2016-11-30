class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  # add votes associaten to Post,relates models and allows us to call post.votes. dependent:destroy  destroys vote when parent post is deleted
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # order posts by created_at in descending order
  default_scope { order('rank DESC') }

  # use a lambda to ensure that a user is present or signed in. if signed in, return all posts. if not, use "joins" to retrieve all posts which belong to public topic
  scope :visible_to, -> (user) {user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true


  def up_votes
    # find up votes for a post by passing value: 1 to where. fetches collection of votes with value of 1.
    votes.where(value: 1).count
  end

  def down_votes
    # find down votes fora post by passing value: -1 to where. fetches only votes with value of -1.
    votes.where(value: -1).count
  end

  def points
    # use ActiveRecord sum method to add value of the given posts votes.
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
end
