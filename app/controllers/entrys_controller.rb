class EntrysController < ApplicationController

  get '/entrys' do
    if logged_in?
      @entrys = Entry.all
      erb :'entrys/index'
    else
      redirect '/login'
    end
  end

  get '/entrys/new' do
    if logged_in?
      erb :'entrys/create_entry'
    else
      redirect '/login'
    end
  end

  post '/entrys' do
    if logged_in?
      if params[:description] == ""
        redirect "/entrys/new"
      else
        @entry = current_user.entrys.build(description: params[:description])
        if @entry.save
          redirect "/entrys/#{@entry.id}"
        else
          redirect "/entrys/new"
        end
      end
    else
      redirect '/login'
    end
  end

  get '/entrys/:id' do
    if logged_in?
      @entry = entry.find_by_id(params[:id])
      erb :'entrys/show_entry'
    else
      redirect '/login'
    end
  end

  get '/entrys/:id/edit' do
    if logged_in?
      @entry = entry.find_by_id(params[:id])
      if @entry && @entry.user == current_user
        erb :'entrys/edit_entry'
      else
        redirect '/entrys'
      end
    else
      redirect '/login'
    end
  end

  patch '/entrys/:id' do
    if logged_in?
      if params[:description] == ""
        redirect "/entrys/#{params[:id]}/edit"
      else
        @entry = entry.find_by_id(params[:id])
        if @entry && @entry.user == current_user
          if @entry.update(description: params[:description])
            redirect  "/entrys/#{@entry.id}"
          else
            redirect "/entrys/#{@entry.id}/edit"
          end
        else
          redirect '/entrys'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/entrys/:id/delete' do
    if logged_in?
      @entry = entry.find_by_id(params[:id])
      if @entry && @entry.user == current_user
        @entry.delete
      end
      redirect '/entrys'
    else
      redirect '/login'
    end
  end
end

