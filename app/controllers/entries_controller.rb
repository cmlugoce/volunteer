class EntriesController < ApplicationController

  get '/entries' do
    if logged_in?
      @entries = Entry.all
      erb :'entries/index'
    else
      redirect '/login'
    end
  end

  get '/entries/new' do
    if logged_in?
      erb :'entries/new'
    else
      redirect '/login'
    end
  end

  post '/entries' do
    if logged_in?
      if params[:description] == ""
        redirect "/entries/new"
      else
        @entry = current_user.entrys.build(description: params[:description])
        if @entry.save
          redirect "/entries/#{@entry.id}"
        else
          redirect "/entries/new"
        end
      end
    else
      redirect '/login'
    end
  end

  get '/entries/:id' do
    if logged_in?
      @entry = entry.find_by_id(params[:id])
      erb :'entries/show'
    else
      redirect '/login'
    end
  end

  get '/entries/:id/edit' do
    if logged_in?
      @entry = entry.find_by_id(params[:id])
      if @entry && @entry.user == current_user
        erb :'entries/edit'
      else
        redirect '/entries'
      end
    else
      redirect '/login'
    end
  end

  patch '/entries/:id' do
    if logged_in?
      if params[:description] == ""
        redirect "/entries/#{params[:id]}/edit"
      else
        @entry = entry.find_by_id(params[:id])
        if @entry && @entry.user == current_user
          if @entry.update(description: params[:description])
            redirect  "/entries/#{@entry.id}"
          else
            redirect "/entries/#{@entry.id}/edit"
          end
        else
          redirect '/entries'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/entries/:id/delete' do
    if logged_in?
      @entry = entry.find_by_id(params[:id])
      if @entry && @entry.user == current_user
        @entry.delete
      end
      redirect '/entries'
    else
      redirect '/login'
    end
  end
end

