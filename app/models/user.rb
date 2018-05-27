class User < ApplicationRecord
    has_secure_password

    has_many :reviews
    has_many :products, through: :reviews

    validates :username, presence: true 
    validates :username, uniqueness: true 

    def logged_in?
        session[:user_id] == self.id 
    end

end
