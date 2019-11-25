class ChatMessage < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }

  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"

  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true
end
