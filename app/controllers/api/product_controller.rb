class Api::ProductController < ApplicationController
  def index
    company = params[:id]
    render json: Product.select("id, name, score").where(company_id: company).order('score desc, id desc').offset(params[:offset]).limit(params[:limit])
  end
end
