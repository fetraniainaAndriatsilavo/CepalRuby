class UsersController < ApplicationController
  # Before actions
  before_action :set_user, only: [:show]
  # Ensures the user is set before showing the user details

  # Wrap parameters for better handling in JSON requests
  wrap_parameters :user, include: [:name, :password, :email]

  # POST /users
  def create
    # Initialize a new user with the provided parameters
    user = User.new(user_params)

    if user.save
      render json: user.as_json(except: :password_digest), status: :created
      # Respond with the created user, excluding the password digest
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      # Respond with validation errors if creation fails
    end
  end

  # GET /users
  def index
    users = User.all
    # Fetch all users from the database
    render json: users.as_json(except: :password_digest)
    # Respond with the list of users, excluding the password digest
  end

  # GET /users/:id
  def show
    render json: @user.as_json(except: :password_digest)
    # Respond with the user details, excluding the password digest
  end

  private

  # Strong parameters for user creation
  def user_params
    params.require(:user).permit(:name, :email, :password)
    # Ensures only the allowed parameters are accepted
  end

  # Set the user for the `show` action
  def set_user
    @user = User.find(params[:id])
    # Finds the user by ID and sets it as an instance variable
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
    # Responds with an error message if the user is not found
  end
end
