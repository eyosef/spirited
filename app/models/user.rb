class User < ApplicationRecord

    has_many :reviews
    has_many :products, through: :reviews

    has_secure_password
    validates :password, :confirmation => true
    validates :password, presence: true
    
    validates :username, presence: true 
    validates :username, uniqueness: true 

    def logged_in?
        session[:user_id] == self.id 
    end



end
