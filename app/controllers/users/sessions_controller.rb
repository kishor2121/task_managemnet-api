class Users::SessionsController < Devise::SessionsController
    # POST /users/sign_in
    def create
      user = User.find_for_authentication(email: params[:user][:email])
  
      if user && user.valid_password?(params[:user][:password])
        sign_in(user)
        token = user.generate_jwt  # Generate the JWT token here
  
        render json: { 
          message: 'User logged in successfully',
          token: token  # Send the JWT token in the response
        }, status: :ok
      else
        render json: { error: 'Invalid Email or Password' }, status: :unauthorized
      end
    end
  end
  