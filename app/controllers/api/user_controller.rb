class Api::UserController < ApplicationController
  def index
  	render json: User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user, :methods => [ :points ]
  end

  def ranking
    @user = User.find(params[:id])
    @user.ranking = User.count(:conditions => ["points > ? AND company_id = ?", @user.get_points, @user.company_id]) + 1
    render json: @user, :methods => :ranking
  end
end
