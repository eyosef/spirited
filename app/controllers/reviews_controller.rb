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

    private 

    def review_params 
        params.require(:review).permit(:product_review, :user, :password, :store_id, :product_id)
    end

end
