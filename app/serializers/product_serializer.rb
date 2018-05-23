class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :store_id
  has_many :stores
end
