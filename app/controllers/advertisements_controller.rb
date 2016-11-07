class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisements = Advertisement.find(params[:id])
  end

  def new
    @advertisements = Advertisement.new
  end

  def create
    @advertisements = Advertisement.new
    @advertisements.title = params[:advertisement][:title]
    @advertisements.body = params[:advertisement][:body]
    @advertisements.price = params[:advertisement][:price]

    # => if we save Post to the database a display success message wil appear
    if @advertisements.save
      # => assign value to flash[:notice]. this provides a way to pass temporary values between actions
      flash[:notice] = "Advertisement was saved."
      redirect_to @advertisements
    else
      # => if not saved, displace error message and render a new view again
      flash.now[:alert] = "There was an error saving the ad. Please try again."
      render :new
    end
  end
end
