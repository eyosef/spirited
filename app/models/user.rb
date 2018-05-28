class User < ApplicationRecord
    has_secure_password

    has_many :reviews
    has_many :products, through: :reviews

    validates :username, presence: true 
    validates :username, uniqueness: true 

    def self.logged_in?
        @user ||= User.find_by_id(session[:user_id])
    end

    def self.access_permitted? 
        unless self.logged_in? 
            flash[:danger] = "Please log in."
            redirect_to new_session_path
        end
    end


end
