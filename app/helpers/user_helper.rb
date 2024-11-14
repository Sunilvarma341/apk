module UserHelper
  # SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  # def self.encode(payload, exp = 24.hours.from_now)
  #   payload[:exp] = exp.to_i
  #   puts "payload ++++++++++++++++  #{payload}"
  #   t=   JWT.encode(payload, SECRET_KEY)
  #   puts  "   token =======  #{t} "
  # end

  # def self.decode(token)
  #   decoded = JWT.decode(token, SECRET_KEY)[0]
  #   HashWithIndifferentAccess.new decoded
  # rescue JWT::DecodeError
  #   nil
  # end

end
