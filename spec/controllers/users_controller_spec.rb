require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:new_user_attributes) do
    {
      name: "BlocHead",
      email: "blochead@bloc.io",
      password: "blochead",
      password_confirmation: "blochead"
    }
  end

  # test new actino for http success
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

  # test create action for HTTP success when issuaing a POST with new_user_attributes
  describe "POST create" do
    it "returns an http redirect" do
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end
    # test that the database count on the users table increases by one when e issue POST to create
    it "creates a new user" do
      expect {
        post :create, user: new_user_attributes
      }.to change(User, :count). by(1)
    end
    # test that user.name is set properly
    it "sets user name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).name).to eq new_user_attributes[:name]
    end
    # test that user.email is set properly
    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end
    # tests that user.password is set properly
    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end
    # test that user.password_confirmation sets properly
    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end

    it "logs the user in after sign up" do
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq assigns(:user).id
    end
  end
end
