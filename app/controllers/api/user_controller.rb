class Api::UserController < ApplicationController
  def index
  	render json: User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user, :methods => :points
  end

  def ranking
    @user = User.find(params[:id])
    render json: @user, :methods => :ranking
  end
end
