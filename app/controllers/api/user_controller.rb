class Api::UserController < ApplicationController
  def index
  	render json: User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user, :methods => :points, :include => [ :subsidiary, :position ], :except => [ :company_id, :subsidiary_id, :position_id ]
  end

  def ranking
    @user = User.find(params[:id])
    render json: @user, :methods => [ :points, :ranking ], :include => [ :subsidiary, :position ], :except => [ :subsidiary_id, :company_id, :position_id ]
  end
end
