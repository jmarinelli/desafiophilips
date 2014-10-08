class SiteController < ApplicationController
  def index
  end
  def login
  	user = User.find_by dni: params[:dni]
  	if user.employee_file_number == params[:employee_file_number]
  		session[:user_id] = user.id
      session[:company_id] = user.company_id
  		redirect_to :action => 'home'
  	else
  		redirect_to :action => 'index', :controller => 'site', :notice => "login-error"
  	end
  end
  def home
    if session[:company_id] and session[:user_id]
      @company = Company.find_by(id: session[:company_id])
      @user = User.find_by(id: session[:user_id])
      @cluster = Subsidiary.find(@user.subsidiary_id).cluster
    else
      redirect_to :action => 'index', :controller => 'site'
    end
  end
end
