require 'pry'
require 'omniauth'
class SessionsController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def new 
        @user = User.new
    end


    def create
        user = User.from_omniauth(env["omniauth.auth"])

        if user.valid?
        session[:user_id] = user.id
        redirect_to request.env['omniauth.origin']
        end
    end

    def destroy
        reset_session
        redirect_to request.referer
    end

    # def create

    #     # if !@user.authenticate(params[:user][:password])
    #     #     return head(:forbidden) 
    #     # else 
    #     #     session[:user_id] = @user.id
    #     #     redirect_to user_url(@user)
    #     # end 
    # end

    # def destroy 
    #     # session.clear 
    #     # redirect_to welcome_url
    # end

end
