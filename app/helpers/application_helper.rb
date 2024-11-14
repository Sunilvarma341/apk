module ApplicationHelper
#   require 'jwt'
#  class JsonWebToken  
#   SECRET_KEY  = Rails.application.credentials.jwt_secret

#   def self.encode(payload ,  exp= 24.hours.from_now)
#     puts "#{payload} =====  exp  #{exp}" 
#     payload[:exp] = exp.to_i 
#     puts "  +++++  encode #{payload}"
#     return  JWT.encode(payload, SECRET_KEY)
#   end

#   def self.decode(token) 
#     decoded = JWT.decode(token, SECRET_KEY)[0]
#     HashWithIndifferentAccess.new decoded
#   rescue  JWT::DecodeError 
#     nil
#   end
#  end
end
