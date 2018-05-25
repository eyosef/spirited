require 'omniauth'
class ReviewsController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def index 
    end

    def new 
        @review = Review.new
        @store = Store.find(params["store_id"])
        @product = Product.find(params["product_id"])
        @users = User.all
    end

    def edit 
        @product = Product.find(params["product_id"])
        @store = Store.find(params["store_id"])
        @review = Review.find(params["id"])
    end 

    def update 
        @review = Review.find(params[:id])
        @user = User.find(params[:user][:id])

        if @user.authenticate(params[:review][:password])
            @review.update(product_review: params[:review][:product_review])

            redirect_to user_path(@user) 
        else 
            redirect_to edit_store_product_review(@review)
        end 
    end


    def create 

        @user = User.find(params[:user][:id])
        @product = Product.find(params[:product_id])
        @store = Store.find(params[:store_id])

        if @user.authenticate(params[:review][:password])

            @review = Review.create(
                product_id: params[:product_id],
                product_review: params[:review][:product_review],
                user_id: params[:user][:id]
                )
            redirect_to store_product_path(@store, @product)
        else 
            redirect_to store_product_path(@store, @product)
        end
    end

    def show 
    end

    def destroy 
        @review = Review.find(params[:format])
        @user = User.find(@review.user_id)

        @review.destroy 

        redirect_to user_path(@user)
    end

    private 

    def review_params 
        params.require(:review).permit(:product_review, :user, :password, :store_id, :product_id)
    end

end
