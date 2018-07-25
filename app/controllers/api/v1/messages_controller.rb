class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.all
    render json: @messages
  end

  def show
    @message = Message.find(params[:id])
    render json: {current_user: @message}
  end

  def create
    @message = Message.create(receiver_id: params[:receiver_id], sender_id: params[:sender_id], message: params[:message])
    render json: @message.to_json
  end

  def update
    @message = Message.find(params[:id])
    @message.update(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :sender_id, :message)
  end
end
