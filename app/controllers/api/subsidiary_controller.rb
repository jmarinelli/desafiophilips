class Api::SubsidiaryController < ApplicationController
  def index
    render json: SubsidiaryHelper.get_subsidiaries, :methods => [ :manager , :sub_manager ], :except => :company_id, :include => :company
  end
end
