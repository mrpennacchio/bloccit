class User < ApplicationRecord
  # register an inline callback directly after the before_save callback.
  before_save { self.email = email.downcase if email.present? }
  # ensure name is present, and has max and min length
  validates :name, length:{ minimum:1, maximum: 100 }, presence: true
  # first validation executes if password_digest is nil. when we create a new user, there is a valid password
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  # when updating user password, and skips validation if no updated password is given
  validates :password, length: { minimum: 6 }, allow_blank: true
  # validates email is present, unique, and correct length
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { minimum: 3, maximum: 254 }
  # requires "password_digest" attribute, saves passwords securely
  # creates two attributes: password and password_confirmation
  has_secure_password
end
