class TopicsController < ApplicationController
  # use the before action filter and require_sign_in method to redirect users who attempt to access actions other than index and show
  before_action :require_sign_in, except: [:index, :show]
  # use another before_action filter to check role of signed in users.
  before_action :authorize_mod, only: [:edit], except: [:index, :show]

  before_action :authorize_user, only: [:create, :new, :delete], except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully"
    else
      flash.now[:alert] = "Error creating topic. Please try again"
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully"
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_mod
    unless current_user.moderator? || current_user.admin?
      flash[:alert] = "You must be a moderator or admin to do that."
      redirect_to topics_path
    end
  end

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path
    end
  end
end
