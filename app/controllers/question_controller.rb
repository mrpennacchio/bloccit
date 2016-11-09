class QuestionController < ApplicationController
  def index
    @question = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]

    if @question.save
      flash[:notice] = "Question was updated."
      redirect_to @question
    else
      flash.now[:alert] = "There was an error saving the question. Please try again"
      render :edit
    end
  end


  def destroy
    @question = Question.find(params[:id])

    # => call destroy on post. if that call is successful, set a flash message and redirect the user to the post index view. else, try again
    if @question.destroy
      flash[:notice] = "\"#{@question.title}\" was deleted successfully"
      redirect_to question_path
    else
      flash.now[:alert] = "There was an error deleting the question"
      render :show
    end
  end

end
