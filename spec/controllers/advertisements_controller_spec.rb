require 'rails_helper'
include RandomData
RSpec.describe AdvertisementsController, type: :controller do
let (:ad) do Advertisement.create!(
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph,
  price: 25)
end


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [ad] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([ad])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      # => pass {id: my_post.id} to show as a parameter with params has
      get :show, {id: ad.id}
      expect(response).to have_http_status(:success)
    end
    # => expect response to return the show view using render_template matcher
    it "renders the #show view" do

      get :show, {id: ad.id}
      expect(response).to render_template :show
    end

    it "assigns ad to @advertisements" do
      get :show, {id: ad.id}
      # => expect post to equal my_post because we call show with id of my_post
      expect(assigns(:advertisements)).to eq(ad)
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
      it "instantiates @advertisements" do
          get :new
          expect(assigns(:advertisements)).not_to be_nil
      end
  end

  describe "ADVERTISEMENT #create" do

    it "increases the number of Advertisement by 1" do
        expect{post :create, advertisements: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Advertisement,:count).by(1)
    end
    # => when create is POSTed to, we expect newly created post to be assigned to @post
    it "assigns the new advertisement to @advertisements" do
        post :create, advertisements: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:advertisements)).to eq Advertisement.last
    end
    # => expect to he be redirected to the newly created post
    it "redirects to the new advertisements" do
        post :create, advertisements: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to Advertisement.last
    end
  end

end
