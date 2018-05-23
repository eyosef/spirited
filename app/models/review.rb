class Review < ApplicationRecord
    scope :newest_first, -> { order(created_at: :desc) }

    belongs_to :user 
    belongs_to :product


end
