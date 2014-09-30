class Api::ProductController < ApplicationController
  def index
    company = params[:id]
    render json: Product.select("id, name, code, score").where(company_id: company).offset(params[:offset]).limit(params[:limit]).order('score desc')
  end
end
