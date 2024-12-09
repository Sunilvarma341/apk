module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by: current_user 
    
    def connect 
      logger.info "WebSocket connection established: "
    end
  end
end
