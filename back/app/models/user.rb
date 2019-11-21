class User < ApplicationRecord
  has_many :books
  has_many :from_chat_messages, class_name: "ChatMessage", foreign_key: "from_id", dependent: :destroy
  has_many :to_chat_messages, class_name: "ChatMessage", foreign_key: "to_id", dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
end
