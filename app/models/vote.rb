class Vote < ApplicationRecord
  # optional: true is a rails 5 convention that associates the vote to the user
  belongs_to :user, optional: true
  belongs_to :post
  after_save :update_post

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote"}, presence: true

  private

  def update_post
    post.update_rank
  end
end
