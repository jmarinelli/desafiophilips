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
  		redirect_to :action => 'index'
  	end
  end
  def home
    unless session[:user_id] and session[:company_id]
      redirect_to :action => 'index'
    end
    @company = Company.find(session[:company_id])
    @user = User.find(session[:user_id])
  end
end
