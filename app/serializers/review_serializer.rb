class ReviewSerializer < ActiveModel::Serializer
    attributes :product_id, :product_review, :product_name
    belongs_to :product
    belongs_to :user

    def product_name
        object.product.name
    end 

  end
  