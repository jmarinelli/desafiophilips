class Api::ProductController < ApplicationController
  def index
    render json: Product.select("name, products.code, scores.value as points").joins(:score)
  end
end
