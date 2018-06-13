require 'omniauth'
class StoresController < JSONAPI::ResourceController

    def index 
        if @user = User.find_by(id: session[:user_id])
            Api.new.stores
            Store1.new.products
            Store2.new.products
            Store3.new.products
            Store4.new.products
            Store5.new.products
            Store6.new.products
            Store7.new.products
            Store8.new.products
            Store9.new.products
            Store10.new.products
            Store11.new.products
            Store12.new.products
            Store13.new.products
            Store14.new.products             
            Store15.new.products
            Store16.new.products
            Store17.new.products
            Store18.new.products
            Store19.new.products
            Store20.new.products
            Store21.new.products
            Store22.new.products
            Store23.new.products
            Store24.new.products
            Store25.new.products

            @stores = Store.all 
        else 
            flash[:notice] = "Please log in."
            redirect_to new_session_path
        end 
    end

    def show 
        if @user = User.find_by(id: session[:user_id])
            @store = Store.find_by(id: params["id"])
        else 
            flash[:notice] = "Please log in."
            redirect_to new_session_path
        end 
    end

end
