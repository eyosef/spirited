require 'pry'
class SessionsController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def new 
        @user = User.new
    end

    def create 
        @user = User.find_by(username: params[:user][:username])
        if !@user.authenticate(params[:user][:password])
            return head(:forbidden) 
        else 
            session[:user_id] = @user.id
            redirect_to user_url(@user)
        end 
    end

    def destroy 
        session.clear 

        redirect_to welcome_url
    end

end
