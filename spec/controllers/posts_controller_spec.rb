require 'rails_helper'
#   test for PostsController. treating it as a controller test
RSpec.describe PostsController, type: :controller do
  # => GET on index view and expects successful http response of 200
  # => create a post, and a assign it to my_post. use RandomData to give my_post random title and body
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    # expect the index to return an array of one item.
    it "assigns [my_post] to @posts" do
      get :index
      # => use assigns methd to give access to instance variables assigned in the action that are available for the view
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
