class ChatController < ApplicationController
  skip_before_action :verify_authenticity_token

  def chat_boot  
  end

  def create_room
    logger.info "created room =========   #{params}   "
    # @room =  Room.new( )

    render :chat_boot
  end
end
