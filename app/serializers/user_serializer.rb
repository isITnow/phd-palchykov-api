class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :role, :created_at
end
