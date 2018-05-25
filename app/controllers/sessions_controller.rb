require 'pry'
require 'omniauth'
class SessionsController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def new 
        @user = User.new
    end


    def create

        if auth = request.env["omniauth.auth"]

            oauth_username = request.env["omniauth.auth"]["extra"]["raw_info"]["login"]
            oauth_uid = request.env["omniauth.auth"]["uid"]
            oauth_provider = request.env["omniauth.auth"]["provider"]
            oauth_password = request.env["omniauth.auth"]["credentials"]["token"]

            if user = User.find_by(:username => oauth_username) 
                session[:user_id] = user.id 

                redirect_to user_path(user)
            else 
                user = User.create(:username => oauth_username, 
                                    :uid => oauth_uid, 
                                    :provider => oauth_provider,
                                    :password => oauth_password)
                session[:user_id] = user.id 
                redirect_to user_path(user)
            end
        else 
            user = User.find_by(:email => params[:email])
            if user && user.authenticate(params[:password])
                session[:user_id] = user.id 
                redirect_to user_path(user)
            else 
                redirect_to welcome_path
            end  
        end 
    end 


    def destroy
        session.clear 
        redirect_to welcome_url
    end


end
