class UsersController < ApplicationController

   get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/entries' 
    end
  end

  get '/login' do
    erb :login
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

  #get signup

  #post signup

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  

  get '/logout' do
    session.clear
    redirect '/'
  end
end