class Api::UserController < ApplicationController
  def index
  	render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def ranking
    @user = User.find(params[:id])
    @user.ranking = User.count(:conditions => ["points > ? AND company_id = ?", @user.points, @user.company_id]) + 1
    render json: @user, :methods => :ranking
  end
end
