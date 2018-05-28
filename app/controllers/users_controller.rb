require 'omniauth'
class UsersController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def new 
        @user = User.new
    end 

    def create 
        user = User.new(user_params)
        user.update(login_params)

        if user.save
            session[:user_id] = user.id 
            flash[:account_success] = "Successfully created an account."
            redirect_to user_url(user)
        elsif !user.authenticate(user_params) 
            flash[:password_mismatch] = "Password and password confirmation do not match."
            redirect_to new_user_url 
        else 
            flash[:failure] = "We could not create an account at this time. Please try again later."
            redirect_to new_user_url 
        end
    end 

    def index 
    end 

    def show 
        @user = User.find(params["id"])
        @new_review = Review.new
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

        @user = User.find_by(id: session[:user_id])

        if @user
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
