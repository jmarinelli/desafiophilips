class Api::CompanyController < ApplicationController
  def index
    render json: Company.select("id, name")
  end
  def user_ranking
    @position = Position.find_by(name: params[:position].split('-').map(&:capitalize).join('-'))

    @users = User.select("users.id, name, dni, employee_file_number, coalesce(sum(scores.value),0) as points")
                 .joins("LEFT OUTER JOIN sales ON sales.user_id = users.id LEFT OUTER JOIN scores ON sales.score_id = scores.id")
                 .where(company_id: params[:id]).where(position_id: @position.id).group("users.id").order("points desc").limit(params[:limit])
    render json: @users
    # render json: @users, :include => [ :position, :sales ], :except => [ :position_id, :company_id, :subsidiary_id ]
  end

  def subsidiary_ranking
  	@subsidiaries = Subsidiary.select("subsidiaries.id, subsidiaries.code, subsidiaries.name, coalesce(sum(scores.value),0) as points")
                              .joins(:users).joins("LEFT OUTER JOIN sales ON sales.user_id = users.id LEFT OUTER JOIN scores ON sales.score_id = scores.id")
                              .where(company_id: params[:id]).group("subsidiaries.id")
                              .order("points desc").limit(params[:limit])
    @subsidiaries.each { |s|
      s.manager = User.select("id, name, employee_file_number, dni").where(subsidiary_id: s.id).where(position_id: 3).take
      s.sub_manager = User.select("id, name, employee_file_number, dni").where(subsidiary_id: s.id).where(position_id: 2).take
    }
    render json: @subsidiaries, :methods => [ :manager, :sub_manager ]
  end
end
