class UsersController < ApplicationController

  get "/create_user" do
    erb :create_user
  end

  post "/create_user" do
    if params[:username]=="" || params[:password]==""
      redirect to '/failure'
    end

    user = User.new(:username => params[:username], :password => params[:password])
    if user.save
			redirect to "/login"
		else
			redirect to "/create_user"
		end
  end

  get '/index' do
    @user = User.find(session[:user_id])
    erb :index
  end


  get "/login" do
    erb :login
  end

  post "/login" do
      user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/account'
    else
      redirect to '/failure'
    end
  end
  
  get '/logout' do
    if is_logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
 

end
