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
            entry = Entry.create(params[:entry])
            log = current_user.logs.find_by(id: params[:log][:id])
            if log
                entry.log_id = log.id
                if entry.save
                redirect to "/entry/#{entry.id}"
                else
                flash[:message] = "Your entry failed to save."
                redirect to "/entry/new"
            end
        else
            redirect to "/entry/new"
        end

        else
            flash[:message] = "You must log in to view this page."
            redirect to "/login"
        end
    end

    get "/entry/:id" do
        if logged_in?
            @entry = current_user.entries.find_by(id: params[:id])
            if @entry
                @log = Log.find_by(id: @entry.log_id)
                erb :"/entries/show"
            else
                flash[:error] = "There is no entry on this page."
                redirect to "/logs"
        end

        else
            flash[:error] = "You must log in to view log entries."
            redirect to "/login"
        end
    end

    get "/entry/:id/edit" do
        if logged_in?
            @entry = current_user.entries.find_by(id: params[:id])
            if @entry
                @logs = current_user.logs
                erb :"/entries/edit"
            else
                redirect to "/logs"
        end

        else
            flash[:error] = "You must log in to view this page."
            redirect to "/login"
        end
    end

    patch '/entry/:id' do
        if logged_in? && params[:name] == "" || params[:location] == ""
                redirect to "/entries/#{params[:id]}/edit"
        else
            @entry = Entry.find_by_id(params[:id])
            if @entry && @entry.user == current_user
                @entry.update(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance])
                flash[:success] = "Successfully edited entry."
                redirect "/entries/#{params[:id]}"
            else
                flash[:error] = "You are not authorized to edit this entry"
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