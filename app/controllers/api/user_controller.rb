class Api::UserController < ApplicationController
  def index
  	render json: User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user, :methods => :points, :include => :subsidiary
  end

  def ranking
    @user = User.find(params[:id])
    render json: @user, :methods => [ :ranking, :points ], :include => :subsidiary
  end
end
