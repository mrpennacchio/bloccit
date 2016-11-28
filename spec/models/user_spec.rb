require 'rails_helper'

RSpec.describe User, type: :model do
  # tests for name
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }

  it { is_expected.to have_many (:posts) }
  it { is_expected.to have_many (:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  # tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  # tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have a name and email attributes" do
      expect(user).to have_attributes(name:"Bloccit User", email: "user@bloccit.com")
    end
    # expect that users will respond to role
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
    # expect users will respond to admin?, which will reutnr whether or not the user is an admin
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
    # expect users to respond to member?
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    # expect users are assigned the role of member by default
    it "is member by default" do
      expect(user.role).to eql("member")
    end

    #test member and admin users within separate contexts
    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false fo #admin?" do
        expect(user.admin?).to be_falsey
      end
    end
    #
    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin" do
        expect(user.admin?).to be_truthy
      end
    end


  end
  # tests for invalid user. true negative
  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
    let(:user_with_invalid_email) {User.new(name:"Bloccit User", email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

  end
end
