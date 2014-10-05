class Api::SubsidiaryController < ApplicationController
  def index
    @subsidiaries = Subsidiary.select("id, name, company_id")
    render json: @subsidiaries, :methods => [ :manager , :sub_manager ], :except => :company_id, :include => :company
  end

  def by_cluster
    cluster = params[:id]
    render json: Subsidiary.select("id, name").where(cluster: cluster)
  end
end
