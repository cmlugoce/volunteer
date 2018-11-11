class UsersController < ApplicationController

  get '/login' do
    erb :login
  end

  post '/register' do
   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.valid?
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    elsif @user.invalid? && User.find_by(username: @user.username)
       flash[:error] = "That username is already taken"
      redirect '/register'
    else
        flash[:error] = "You must fill out all fields to sign up."
        redirect '/register'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
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