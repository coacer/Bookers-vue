class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :profile_image_url
end
