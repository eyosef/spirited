class ProductsController < JSONAPI::ResourceController 

    def show 
        @store = Store.find(params["store_id"])
        @product = Product.find(params["id"])
    end

end
