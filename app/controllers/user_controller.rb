class UserController < ApplicationController
  # Skip CSRF token verification for specific actions
  skip_before_action :verify_authenticity_token, only: [:postUserDetails, :userLogin]

  def userLogin
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
      }
    else
      # Render unauthorized response for invalid credentials
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
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

  def postUserDetails
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