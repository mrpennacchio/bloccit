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

  # => when :new is invoked, a new and unsaved post object is created. when create is invoke, newly created object is presisted to the database
  #    this mimics the RESTful parts of HTTP. :new does not generate new data
  describe "GET new" do
      it "returns http success" do
          get :new
          expect(response).to have_http_status(:success)
      end
      # => we expect PostsController#new to render the posts new view...with render_template
      it "renders the #new view" do
          get :new
          expect(response).to render_template :new
      end
      # => we expect @post instance variable to be initialized by PostsController#new.
      #    assigns gives us access to the @post variable, and assigns @post to :post
      it "instantiates @post" do
          get :new
          expect(assigns(:post)).not_to be_nil
      end
  end


  describe "POST create" do
      # => after PostsController#create is called, Post instances will increase by 1
      it "increases the number of Post by 1" do
          expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      # => when create is POSTed to, we expect newly created post to be assigned to @post
      it "assigns the new post to @post" do
          post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
          expect(assigns(:post)).to eq Post.last
      end
      # => expect to he be redirected to the newly created post
      it "redirects to the new post" do
          post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
          expect(response).to redirect_to Post.last
      end
  end


  describe "GET show" do
    it "returns http success" do
      # => pass {id: my_post.id} to show as a parameter with params has
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    # => expect response to return the show view using render_template matcher
    it "renders the #show view" do

      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      # => expect post to equal my_post because we call show with id of my_post
      expect(assigns(:post)).to eq(my_post)
    end
  end

  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
