class Api::CompanyController < ApplicationController
  def index
    render json: Company.select("id, name")
  end
  def user_ranking
    @position = Position.find_by(name: params[:position].split('-').map(&:capitalize).join('-'))

    render json: User.top(params[:id], @position.id, params[:limit]), :include => :subsidiary
  end

  def subsidiary_ranking
  	@subsidiaries = Subsidiary.top(params[:id], params[:limit])
    render json: @subsidiaries, :methods => [ :manager, :sub_manager ]
  end
end
