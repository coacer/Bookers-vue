class Api::V1::RoomController < ApplicationController
  def messages
    messages = ChatMessage.where(room_id: params[:roomId])
    render json: messages
  end
end
