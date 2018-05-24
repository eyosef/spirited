class Review < ApplicationRecord
    scope :newest_first, -> { order(created_at: :desc) }

    belongs_to :user 
    belongs_to :product

    validates :product_review, :presence => true 
    validates :product_review, :uniqueness => true 

end
