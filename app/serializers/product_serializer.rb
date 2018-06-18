class ProductSerializer < ActiveModel::Serializer
  attributes :store_id
  has_many :stores
  has_many :reviews
  has_many :users, through: :reviews
end
