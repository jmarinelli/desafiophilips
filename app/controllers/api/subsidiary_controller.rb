class Api::SubsidiaryController < ApplicationController
  def index
    @subsidiaries = Subsidiary.select("code, name, company_id")
    render json: @subsidiaries, :methods => [ :manager , :sub_manager ], :except => :company_id, :include => :company
  end
end
