require 'omniauth'
class UsersController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def new 
        @user = User.new
    end 

    def create 
        
        user = User.new(user_params)

        if user.save && user.create_login(login_params)
            head 200 
            # session[:user_id] = user.id 
            # redirect_to user_url(user)
        else 
            head 422
            # redirect_to new_user_url 
        end
    end 

    def index 
    end 

    def show 
        @user = User.find(params["id"])
        session[:user_id] = @user.id

        @user.reviews.each do |review|
            @product = review.product 
            @store = @product.store 
        end 

    end

    def edit 
        @user = User.find(params["id"])
    end

    def update 

        @user = User.find(params[:id])

        if !@user.provider.nil?
            @user.update(user_params)
            redirect_to user_path(@user) 
        elsif @user.provider.nil?
            @user.authenticate(params[:user][:password])
            @user.update(user_params)
            redirect_to user_path(@user) 
        else 
            redirect_to edit_user_path(@user)
        end 
    end

    private 

    def user_params 
        params.require(:user).permit(:first_name, :last_name, :username)
    end

    def login_params
        params.require(:user).permit(:identification, :password, :password_confirmation)
      end

end
