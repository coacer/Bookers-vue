class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    json_message = ActiveModelSerializers::SerializableResource.new(message, {}).as_json
    ActionCable.server.broadcast "room_channel_#{message.room_id}", json_message
  end
end
