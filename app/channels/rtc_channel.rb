class RtcChannel < ApplicationCable::Channel
  
  @@channel = {} 

  def subscribed
    # stream_from "some_channel"
    logger.info "Stream started for user: "
    stream_for "rtc_channel" 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    logger.info "Stream ended unsubscribed: "
    clear_connection
  end


  def join(data) 
    channel_name =  data['channelName']
    user_id  =  data['user_id'] 
    @@channel ||= {} 
    @@channel[channel_name][user_id] = connection 
    broadcast_users(channel_name) 
  end

  def quit(data) 
    channel_name =  data['channelName'] 
    user_id =  data['user_id']
    if @@channel[channel_name]
      @@channel[channel_name].delete(user_id) 
      @@channel.delete(channel_name) if @@channel[channel_name].empty?
    end
  end

  def send_offer(data)
    send_to_peers(data,  'offer_sdp_received')
  end
 

   def send_answer(data)
    send_to_peers(data,  'answer_sdp_received')
   end

   def send_ice_candidate(data) 
    send_to_peers(data,  'ice_candidate_received')
   end

   private 
   def broadcast_users(channel_name)
    user_ids =  @@channel[channel_name]&.keys  || [] 
    ActionCable.server.broadcast("rtc_channel" ,  {
       type: 'joined' , 
       body: user_ids, 
    })
   end

   def send_to_peers(data , event )
    channel_name =  data['channelName'] 
    userId =  data['user_id']
    body =  data['body'] 

    @@channel[channel_name]&.each   do |id , conn|
       next  if id.to_s == userId.to_s 

       conn.transmit({
        type: event, 
        msg_body: body
       })
    end
   end

   def clear_connection
    @@channel.each do  |channel_name ,  users|
      users.delete_if {|id ,  conn|  conn == connection} 
      @@channel.delete(channel_name) if  users.empty 
    end 
   end
end