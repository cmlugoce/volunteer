class UsersController < ApplicationController

  # get '/signup' do
  #   if !logged_in?
  #     erb :'users/signup'
  #   else
  #     redirect to '/entrys' 
  #   end
  # end

  # post '/signup' do
  #   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  #     session[:user_id] = @user.id
  #     redirect '/entrys'
    # if 
    #   params[:username] == "" || params[:email] == "" || params[:password] == ""
    #   flash[:signup_message] = "Please fill out all required fields (name, email, and password)"
    #   redirect '/signup'
    # elsif
    #   !User.new(:username => params[:username], :password => params[:password]).valid?
    #   flash[:failure_message] = "Username is taken, please choose another username."
    #   redirect '/signup'
    # elsif 
    #   params[:email] != params[:confirm_email]
    #   flash[:message] = "This email already exists. Please enter a new email or log in to continue."
    #   redirect to '/signup'
    # elsif 
    #   params[:password] != params[:confirm_password]
    #   flash[:failure] = "Passwords do not match"
    #   redirect '/signup'
  # end
# end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(password: params["password"])
      session[:user_id] = user.id
      redirect "users/#{@user.id}"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end