class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # register an inline callback directly after the before_save callback.
  before_save { self.email = email.downcase if email.present? }

  # same as self.role = :member if self.role.nil?
  before_save { self.role ||= :member }

  # ensure name is present, and has max and min length
  validates :name, length:{ minimum: 1, maximum: 100 }, presence: true
  # first validation executes if password_digest is nil. when we create a new user, there is a valid password
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  # when updating user password, and skips validation if no updated password is given
  validates :password, length: { minimum: 6 }, allow_blank: true
  # validates email is present, unique, and correct length
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  # requires "password_digest" attribute, saves passwords securely
  # creates two attributes: password and password_confirmation
  has_secure_password

  # assigning an integer 0 to member, and 1 to admin in the database
  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def user_has_favorites
    self.favorites.any?
  end

end
