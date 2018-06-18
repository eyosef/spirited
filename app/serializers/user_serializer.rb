class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name
  has_many :reviews
  has_many :products, through: :reviews
  has_many :notes
end
