class UsersController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def new 
        @user = User.new
    end 

    def create 
        
        user = User.new(user_params)

        if user.valid?
            user.save
            session[:user_id] = user.id 
            redirect_to user_url(user)
        else 
            redirect_to new_user_url 
        end
    end 

    def index 
    end 

    def show 
        @user = User.find(params["id"])
        session[:user_id] = @user.id
    end

    def edit 
        @user = User.find(params["id"])
    end

    def update 

        @user = User.find(params[:id])

        if @user.authenticate(params[:user][:password])
            @user.update(user_params)

            redirect_to user_path(@user) 
        else 
            redirect_to edit_user_path(@user)
        end 
    end

    private 

    def user_params 
        params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation)
    end

end
