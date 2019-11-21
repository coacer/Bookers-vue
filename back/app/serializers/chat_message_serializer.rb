class ChatMessageSerializer < ActiveModel::Serializer
  attributes :id, :room_id, :from_id, :to_id, :content
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
end
