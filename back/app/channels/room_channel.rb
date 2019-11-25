class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:roomId]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ChatMessage.create!(
      from_id: data['fromId'],
      to_id: data['toId'],
      room_id: data['roomId'],
      content: data['content']
    )
  end
end
