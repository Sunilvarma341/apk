# app/lib/json_web_token.rb
require 'jwt'

 class JsonWebToken  
  SECRET_KEY  = Rails.application.secrets.secret_key_base

  # .secrets.secret_key_basez

  def self.encode(payload ,  exp= 24.hours.from_now)
    puts "#{payload} =====  exp  #{exp}" 
    payload[:exp] = exp.to_i 
    puts "  +++++  encode #{payload}"
    return  JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
     HashWithIndifferentAccess.new decoded
  rescue  JWT::DecodeError => e
    puts "rescuew decode   #{e}"
    nil
  end
 end
