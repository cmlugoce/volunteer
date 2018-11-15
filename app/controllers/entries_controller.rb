class EntriesController < ApplicationController

    get "/entry/new" do
        if logged_in?
            @logs = current_user.logs
            erb :"/entries/new"
        else
            flash[:message] = "You must be logged in to view this page."
            redirect to "/login"
        end
    end

    post "/entry" do
      if logged_in?
      if params[:content] == ""
        redirect to "/entries/new"
      else
        @entry = current_user.entrys.build(title: params[:title], location: params[:location], date: params[:date], description: params[:desscription], user_id: session[:user_id])
        if @entry.save
          redirect to "/entries/#{@entry.id}"
        else
          redirect to "/entries/new"
        end
      end
    else
      redirect to '/login'
      end
    end

    get "/entry/:id" do 
        if logged_in?
         @entry = Entry.find_by_id(params[:id])
            erb :'entries/show_entry'
        else
            redirect to '/login'
        end
    end

    get "/entry/user_id/edit" do
        if logged_in?
            @entry = current_user.entries.find_by(user_id: params[:user_id])
            if @entry
                @logs = current_user.logs
                erb :"/entries/edit"
            else
                redirect to "/logs"
        end
        else
            redirect to '/login'
        end
    end

    patch '/entries/:id' do #updates entries based on ID in the url
        if logged_in? && params[:user_id] == "" || params[:title] == ""
               redirect to "/entries/#{params[:user_id]}/edit"
        else
            @entry = Entry.find_by_id(params[:user_id])
            if @entry && @entry.user == current_user
                @entry.update(user_id: params[:user_id], title: params[:title, points: params[:points])
                flash[:success] = "You have successfully edited this entry."
                redirect "/entries/#{params[:user_id]}"
            else
                flash[:error] = "You are not authorized to edit this entry."
                redirect to '/entries'
            end
        end
    end

    get "/entry/:id/delete" do
        if logged_in?
            entry = current_user.entries.find_by(id: params[:id])
            if entry && entry.destroy
                log = Log.find_by(id: entry.log_id)
                flash[:error] = "Your entry has been deleted."
                redirect to "/logs/#{log.id}"
            else
                redirect to "/logs" 
        end

        else
            flash[:error] = "You must log in to delete an entry."
            redirect to "/login"
        end
    end
end
