class ApplicationController < ActionController::Base
  # protect_from_forgery unless: -> { request.format.json? 
  # before_action :auth_request
  # skip_before_action :auth_request, only: [:userLogin]
  before_action :auth_request, except: [:userLogin , :chat_boot, :create_room ,  :login ,:sign_up , :postUserDetails ,  :mob_post_user_details  , :mob_user_login]

  if Rails.env.development?
    puts "Running in development mode"
  elsif Rails.env.production?
    puts "Running in production mode"
  elsif Rails.env.test?
    puts "Running in test mode"
  end
  
  
 private

  def auth_request 
    auth_header = request.headers['Authorization']
    auth_token =  auth_header
    token = auth_token&.start_with?("Bearer") ?
     auth_token.split(' ').last 
    : nil

    if token.nil?
      render json: { error: "Missing token" }, status: :unauthorized
      return
    end
    decoded = JsonWebToken.decode(token)
    user_id = decoded[:user_id] if decoded
   
    if decoded && user_id
      @current_user = User.find_by(id: user_id)
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end

  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def header_token
    auth_header = request.headers['Authorization']
    puts "Authorization Header from header_token method: #{auth_header}"
    return auth_header&.start_with?('Bearer') ? auth_header.split(' ').last : nil
  end



end
