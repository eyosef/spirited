require 'omniauth'
class ReviewsController < JSONAPI::ResourceController
    skip_before_action :verify_authenticity_token

    def index 
    end

    def new 
        @review = Review.new
        @new_review = Review.new
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
        @user = User.find_by(id: session[:user_id])
        updated_review = params[:review][:product_review] 
        
        if updated_review.blank?
            flash[:update_review] = "Reviews must have a minimum of 10 characters."
            redirect_to user_path(@user)
        elsif !updated_review.blank? && @user 
            @review.update(product_review: params[:review][:product_review])
            flash[:update_review] = "Sucessfully updated review!"
            redirect_to user_path(@user)
        else 
            flash[:update_review] = "We were unable to update this review. Reviews must have a minimum of 10 characters. Please try again."
            redirect_to user_path(@user)
        end 
    end


    def create 
        @user = User.find_by(id: session[:user_id])
        @product = Product.find(params[:product_id])
        @store = Store.find(params[:store_id])

        if @user.valid?
            review = Review.create(
                product_id: params[:product_id],
                product_review: params[:review][:product_review],
                user_id: @user.id
                )
            review.save
            redirect_to store_product_path(@store, @product), notice: "Successfully published a review!"
        else 
            redirect_to store_product_path(@store, @product), notice: "Could not publish the review at this time. Please try again later."
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

end
