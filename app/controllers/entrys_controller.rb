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














#     get '/entrys' do
#         if logged_in?
#             @user = current_user
#             session[:user_id] = @user.id
#             @entrys = Entry.all
#             erb :'entrys/index'
#         else
#             flash[:message] = "Signup or login to access entries."
#             redirect '/login'
#         end
#     end
    
#     get '/entrys/new' do
#         if logged_in?
#             @entrys = Entry.all
#             erb :'/entrys/new'
#         else
#             flash[:message] = "You must be logged in to view this page."
#             redirect to '/login'
#         end
#     end

#     post '/entrys' do
#       if Entry.new(params[:entry]).valid?
#         @entry = current_user.entrys.create(params[:entry])
#         @entry.save
#       if !params[:log][:title].empty?
#           @Entry.logs << Log.create(title: params[:log][:title])
#       end
#             redirect '/entrys/#{@entry.id}'
#       else
#             flash[:new_entry] = "Please create your entry."
#             redirect '/entrys/new'
#             end
#         end
#     end

#     get "/entrys/:id" do 
#         if logged_in?
#             @entry = Entry.find_by_id(params[:id])
#             erb :'entrys/show'
#         else
#             redirect to '/login'
#         end
#     end

#     get "/entrys/:id/edit" do
#         if logged_in?
#             @entry = current_user.entrys.find_by(id: params[:id]) 
#             if @entry
#                 @logs = current_user.logs
#                 erb :"/entrys/edit"
#             else
#                 redirect to "/logs"
#         end
#         else
#             redirect to '/login'
#         end
#     end

#     patch '/entrys/:id' do 
#         #updates entrys based on ID in the url
#         if logged_in? && params[:id] == "" || params[:title] == ""
#                redirect to "/entrys/#{params[:id]}/edit"
#         else
#             @entry = Entry.find_by_id(params[:id])
#             if @entry && @entry.user == current_user
#                 @entry.update(id: params[:id], title: params[:title], points: params[:points])
#                 flash[:success] = "You have successfully edited this entry."
#                 if !params[:log][:title].empty?
#                     @entry.logs << Log.create(title: params[:log][:title])
#                 # redirect "/entrys/#{params[:id]}"
#             else
#                 flash[:error] = "You are not authorized to edit this entry."
#                 redirect to '/entrys'
#             end
#         end
#     end

#     get "/entry/:id/delete" do
#         if logged_in?
#             entry = current_user.entrys.find_by(id: params[:id])
#             if entry && entry.destroy
#                 log = Log.find_by(id: entry.log_id)
#                 flash[:error] = "Your entry has been deleted."
#                 redirect to "/logs/#{log.id}"
#             else
#                 redirect to "/logs" 
#         end

#         else
#             flash[:error] = "You must log in to delete an entry."
#             redirect to "/login"
#         end
#     end
# end
