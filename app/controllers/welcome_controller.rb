class WelcomeController < ApplicationController
  def index
  end
  def login
  	user = User.find(params[:dni])
  	if user.password == params[:password]
  		session[:user_id] = params[:dni]
  		redirect_to :action => 'home'
  	else
  		redirect_to :action => 'index'
  	end
  end
  def home
  	@user = User.find(session[:user_id])
  end
end
