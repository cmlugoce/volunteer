class LogsController < ApplicationController
    
    get '/logs/new' do
        erb :'/logs/new'
    end
    
    post '/logs' do
        if logged_in?
            @user = current_user
            session[:user_id] = @user.id
            @logs = log.all
        erb :'/logs/index'

        else
            redirect to '/login'
        end
    end

    get '/logs/:id' do
        @log = Log.find(params[:id])
        erb :'/logs/show'
    end
  end   
