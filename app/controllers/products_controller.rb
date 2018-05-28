require 'omniauth'
class ProductsController < JSONAPI::ResourceController 

    def show 
        if @user = User.find_by(id: session[:user_id])
            @store = Store.find(params["store_id"])
            @product = Product.find(params["id"])
        else 
            flash[:notice] = "Please log in."
            redirect_to new_session_path
        end 
    end

end
