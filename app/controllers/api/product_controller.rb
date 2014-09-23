class Api::ProductController < ApplicationController
  def index
    render json: Product.all
  end
end
