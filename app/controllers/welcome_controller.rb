class WelcomeController < ApplicationController
  def index
  end
  def login
  	user = User.find(params[:dni])
  	if user.password == params[:password]
  		session[:user_id] = params[:dni]
  		redirect_to :controller => user.company.name, :action => 'index'
  	else
  		redirect_to :action => 'index'
  	end
  end
end
