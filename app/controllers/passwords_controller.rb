class PasswordsController < JSONAPI::ResourceController 

    def new
        @user = User.find_by(id: params[:format])
    end

end
