class Api::V1::RoomController < ApplicationController
  def get_info
    room_id = calc_room_id(params[:currentUserId].to_i, params[:otherUserId].to_i)
    messages = ChatMessage.where(room_id: room_id)
    render json: { roomId: room_id, messages: messages }
  end

  private
  def calc_room_id(first_id, second_id)
    if first_id < second_id
      "#{first_id}-#{second_id}"
    else
      "#{second_id}-#{first_id}"
    end
  end
end
