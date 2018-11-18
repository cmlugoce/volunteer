class UsersController < ApplicationController

   get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?

      erb :'users/create_user'

    else
      redirect to '/entrys'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""

      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id

      redirect to '/entrys'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/entrys'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/entrys"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end











#   get '/signup' do
#     if logged_in?
#       redirect to '/entrys' 
#     else
#       erb :'users/signup'
#     end
#   end

#   post '/signup' do
#     @user = User.new(username: params[:username], email: params[:email], password: params[:password])
#       @user.save
#     session[:user_id] = @user.id
#       redirect to '/entrys' 
# end

#   get '/login' do
#     if !logged_in?
#       erb :'/users/login'
#     else
#       redirect to '/entrys'
#     end
#   end

#   post '/login' do
#     user = User.find_by(username: params["username"])
#     if user && user.authenticate(password: params["password"])
#       session[:user_id] = user.id
#       redirect "users/#{@user.id}"
#     else
#       redirect '/login'
#     end
#   end

#   get '/users/:id' do
#     @user = User.find_by(id: params[:id])
#     erb :'/users/show'
#   end

#   get '/logout' do
#     session.clear
#     redirect '/'
#   end
# end