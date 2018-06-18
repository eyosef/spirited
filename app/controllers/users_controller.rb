require 'omniauth'
class UsersController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def index 
        @user = User.first
        @users = User.all

        respond_to do |format|
            format.html { render :index }
            format.json { render json: @users }
        end
    end 

    def new 
        @user = User.new
    end 

    def create 
        user = User.new(user_params)
        user.update(login_params)

        if user.save
            session[:user_id] = user.id 
            flash[:update] = "Successfully created an account."
            redirect_to user_url(user)
        elsif user.username.blank? || user.first_name.blank? || user.last_name.blank? || user.password.blank? || user.password_confirmation.blank?
            flash[:update] = "The form must be completed to create a new account. Please fill all entries."
            redirect_to new_user_url
        elsif !user.authenticate(user_params) 
            flash[:update] = "Password and password confirmation do not match."
            redirect_to new_user_url 
        else 
            flash[:update] = "We could not create an account at this time. Please try again later."
            redirect_to new_user_url 
        end
    end 

    def show 
        @user = User.find(session[:user_id])
        @note = Note.new 
        
        @user.reviews.each do |review|
            @product = review.product 
            @store = @product.store 
        end 

        respond_to do |format|
            format.html { render :show }
            format.json { render json: @user }
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
