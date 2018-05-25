class AuthenticatedController < ApplicationController


    include RailsApiAuth::Authentication

    before_action :authenticate_admin!

    def index
        render json: { success: true }
    end

    private

    def authenticate_admin!
        authenticate! do
            current_login.account.admin?
        end
    end
  
end
