require './config/environment'
#require "rack-flash"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_volunteer_journal_app"
    #use Rack::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      user = User.find_by(id: session[:user_id])
      return user if user
    end

  end
end