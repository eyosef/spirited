class Product < ApplicationRecord
    belongs_to :store

    has_many :reviews 
    has_many :users, through: :reviews 

end
