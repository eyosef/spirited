module UsersHelper 

    def logged_in?
        @user ||= User.find_by_id(session[:user_id])
    end

    def access_permitted? 
        unless self.logged_in? 
            flash[:danger] = "Please log in."
            redirect_to new_session_path
        end
    end

end