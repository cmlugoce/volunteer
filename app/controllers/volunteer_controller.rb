class VolunteerController < ApplicationController
    
    get '/volunteer_logs/new' do
        erb :'/volunteer_logs/new'
    end
    
    post '/volunteer_logs' do
        if logged_in?
            @user = current_user
            session[:user_id] = @user.id
            @volunteers = Volunteer.all
        erb :'/volunteers/index'

        else
            redirect to '/login'
        end
    end

    get '/volunteer_logs/:id' do
        @volunteer_log = VolunteerLog.find(params[:id])
        erb :'/volunteer_logs/show'
    end
  end   
