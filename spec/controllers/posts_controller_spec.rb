require 'rails_helper'
#   test for PostsController. treating it as a controller test
RSpec.describe PostsController, type: :controller do
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  # => GET on index view and expects successful http response of 200
  # => create a post, and a assign it to my_post. use RandomData to give my_post random title and body
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }


  # => when :new is invoked, a new and unsaved post object is created. when create is invoke, newly created object is presisted to the database
  #    this mimics the RESTful parts of HTTP. :new does not generate new data
  describe "GET new" do
      it "returns http success" do
          get :new, topic_id: my_topic.id
          expect(response).to have_http_status(:success)
      end
      # => we expect PostsController#new to render the posts new view...with render_template
      it "renders the #new view" do
          get :new, topic_id: my_topic.id
          expect(response).to render_template :new
      end
      # => we expect @post instance variable to be initialized by PostsController#new.
      #    assigns gives us access to the @post variable, and assigns @post to :post
      it "instantiates @post" do
          get :new, topic_id: my_topic.id
          expect(assigns(:post)).not_to be_nil
      end
  end


  describe "POST create" do
    # => after PostsController#create is called, Post instances will increase by 1
    it "increases the number of Post by 1" do
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
    # => when create is POSTed to, we expect newly created post to be assigned to @post
    it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
    end
    # => expect to he be redirected to the newly created post
    it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
    end
  end


  describe "GET show" do
    it "returns http success" do
      # => pass {id: my_post.id} to show as a parameter with params has
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    # => expect response to return the show view using render_template matcher
    it "renders the #show view" do

      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, topic_id: my_topic.id, id: my_post.id
      # => expect post to equal my_post because we call show with id of my_post
      expect(assigns(:post)).to eq(my_post)
    end
  end


  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      # => expect edit view to render when a post is edited
      expect(response).to render_template :edit
    end

    # => test that edit assigns the correct post to be updated to @post
    it "assigns the post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_post.id

      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      # => test that @post was updated with the title and body passed to update, adn taht @post's id was not changed
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      # => we expect to be redirected to the posts show view after the update
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to [my_topic, my_post]
    end
  end


  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      # => search the database for a post with an id equal to my_post. it returns an array
      #    we assign a the size of the array to count, expect count to be equal to 0
      #    This asserts that the database wont have a matching post once destroy is called
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      # => expect to be redirected to the posts index view after a post has been deleted
      expect(response).to redirect_to my_topic
    end
  end

end
