require 'rails_helper'
include RandomData
RSpec.describe QuestionController, type: :controller do
let (:my_question) { Question.create(id: 1, title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false)}


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_question to @question" do
      get :index
      expect(assigns(:question)).to eq([my_question])
    end
  end

  describe "GET show" do
    it "returns http success" do
      # => pass {id: my_post.id} to show as a parameter with params has
      get :show, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end
    # => expect response to return the show view using render_template matcher
    it "renders the #show view" do
      get :show, {id: my_question.id}
      expect(response).to render_template :show
    end

    it "assigns my_question to @question" do
      get :show, {id: my_question.id}
      # => expect post to equal my_post because we call show with id of my_post
      expect(assigns(:question)).to eq(my_question)
    end
  end

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
      it "instantiates @question" do
          get :new
          expect(assigns(:question)).not_to be_nil
      end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_question.id}
      # => expect edit view to render when a post is edited
      expect(response).to render_template :edit
    end

    # => test that edit assigns the correct post to be updated to @post
    it "assigns the post to be updated to @question" do
      get :edit, {id: my_question.id}

      question_instance = assigns(:question)

      expect(question_instance.id).to eq my_question.id
      expect(question_instance.title).to eq my_question.title
      expect(question_instance.body).to eq my_question.body
    end
  end


  describe "PUT update" do
    it "updates question with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_question.id, question: {title: new_title, body: new_body}

      # => test that @poist was updated with the title and body passed to update, adn taht @post's id was not changed
      updated_question = assigns(:question)
      expect(updated_question.id).to eq my_question.id
      expect(updated_question.title).to eq new_title
      expect(updated_question.body).to eq new_body
    end

    it "redirects to the updated question" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      # => we expect to be redirected to the posts show view after the update
      put :update, id: my_question.id, question: {title: new_title, body: new_body}
      expect(response).to redirect_to my_question
    end
  end

  describe "DELETE destroy" do
    it "deletes the question" do
      delete :destroy, {id: my_question.id}
      # => search the database for a post with an id equal to my_post. it returns an array
      #    we assign a the size of the array to count, expect count to be equal to 0
      #    This asserts that the database wont have a matching post once destroy is called
      count = Question.where({id: my_question.id}).size
      expect(count).to eq 0
    end

    it "redirects to question index" do
      delete :destroy, {id: my_question.id}
      # => expect to be redirected to the posts index view after a post has been deleted
      expect(response).to redirect_to question_path
    end
  end

end
