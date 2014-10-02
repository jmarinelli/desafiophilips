class Api::CompanyController < ApplicationController
  def index
    render json: Company.select("id, name")
  end

  def users
    render json: User.select("*").where(company_id: params[:id]).limit(params[:limit]).offset(params[:offset])
  end

  def cluster_users
    render json: User.select("*").where(company_id: params[:id]).where(cluster: params[:cluster_id]).limit(params[:limit]).offset(params[:offset])
  end

  def cluster_ranking
    @position = Position.find_by(name: params[:position].split('-').map(&:capitalize).join('-'))

    render json: User.top(params[:id], params[:cluster_id], @position.id, params[:limit]), :include => :subsidiary
  end

  def subsidiary_ranking
  	@subsidiaries = Subsidiary.top(params[:id], params[:limit])
    render json: @subsidiaries, :methods => [ :manager, :sub_manager ]
  end
end
