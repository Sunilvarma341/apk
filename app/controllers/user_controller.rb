class UserController < ApplicationController
  # Skip CSRF token verification for specific actions
  skip_before_action :verify_authenticity_token, only: [:postUserDetails, :userLogin , :login  ,   :mob_post_user_details  , :mob_user_login  ]

  def login
    puts "------------------------"
  end

  def sign_up 
    puts "sign up  started"
  end

  # Handles login form submission
  def userLogin
    user_params = params
    user = User.find_by(email: user_params[:email])

    if user&.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      cookies[:auth_token] = { value: token, httponly: true, secure: Rails.env.production? }
      redirect_to root_path, notice: "Login successful"
    else
      flash[:alert] = 'Invalid email or password'
      redirect_to login_user_index_path
    end
  rescue => e
    Rails.logger.error "Error in UsersController#login: #{e.message}"
    flash[:alert] = 'An unexpected error occurred. Please try again later.'
    redirect_to login_user_index_path
  end
  
  

  def postUserDetails
    Rails.logger.info "Received params: #{params.inspect}" # Logging for debugging
  
    user_params = params.permit(:email, :password)
    user = User.new(user_params)
  
    if user.save
      redirect_to login_user_index_path, notice: "Sign up successful"
    else
      flash[:alert] = user.errors.full_messages.to_sentence
      redirect_to sign_up_user_index_path
    end
  rescue => e
    Rails.logger.error "Error in UsersController#post_user_details: #{e.message}"
    flash[:alert] = 'An unexpected error occurred. Please try again later.'
    redirect_to sign_up_user_index_path
  end


  def logout 
    pust "logoutlogoutlogoutlogoutlogoutlogoutlogout"
    cookies.delete(:auth_token) 
    reset_session 
    redirect_to  login_user_index_path , notice: "Logged out successfully"
  end
  

  ##################################################
  
  def mob_user_login 
  # Find user by email
  user = User.find_by(email: params[:user][:email])

  # Authenticate user if found
  if user&.authenticate(params[:user][:password])
    # Generate a token and respond with user details
    token = JsonWebToken.encode(user_id: user.id)
    
      render json: {  
        token: token,
        userDetails: user,
        status: :ok
      }, status: :ok
  else
    render json: { error: 'Invalid credentials' }, status: :unauthorized
  end
  rescue => e
  Rails.logger.error "Error in SessionsController#userLogin: #{e.message}"
    render json: { error: 'Something went wrong' }, status: :internal_server_error
  end


  def getToken
    # Find a specific user by email and generate a token
    user = User.find_by(email: 'users1@example.com')
    if user
      token = JsonWebToken.encode(user_id: user.id)
      render json: {
        token: token,
        status: :ok
      }
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def  mob_post_user_details
    # Create a new user with provided params
    user = User.new(user_params)

    # Save user and respond with a token if successful
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      response.set_header('Authorization', "Bearer #{token}")
      render json: { user: user, status: :created }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for user creation
  def user_params
    params.require(:user).permit(:password, :email)
  end

  # Helper method to extract the token from the Authorization header
  def header_token
    auth_header = request.headers['Authorization']
    auth_header.split(" ").last if auth_header&.start_with?("Bearer")
  end
end

# def valid_authorization(token)
#   decoded = JsonWebToken.decode(token)
  
#   if decoded
#     @current_user = User.find_by(id: decoded[:user_id])
#     return true if @current_user
#   end
  
#   false
# rescue ActiveRecord::RecordNotFound, JWT::DecodeError
#   render json: { errors: 'Unauthorized' }, status: :unauthorized
# end