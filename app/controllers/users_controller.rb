class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  wrap_parameters :user, include: [:name,:password, :email]

    # POST /users
  def create
    user = User.new(user_params)

    if user.save
      render json: user.as_json(except: :password_digest), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users
  def index
    users = User.all
    render json: users.as_json(except: :password_digest)
  end

  # GET /users/:id
  def show
    render json: @user.as_json(except: :password_digest)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
