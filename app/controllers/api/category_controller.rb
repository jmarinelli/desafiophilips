class Api::CategoryController < ApplicationController
  def index
    render json: Category.all
  end
end
