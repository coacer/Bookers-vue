class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :books
  has_many :from_chat_messages, class_name: "ChatMessage", foreign_key: "from_id", dependent: :destroy
  has_many :to_chat_messages, class_name: "ChatMessage", foreign_key: "to_id", dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true

  def profile_image_url
    profile_image.attached? ? url_for(self.profile_image) : "/no_image.jpg"
  end
end
