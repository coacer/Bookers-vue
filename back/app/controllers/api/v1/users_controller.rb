class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def index
    users = User.all.reverse
    render json: users
  end

  def show
    render json: @user
  end

  def login
    user = User.find_by(email: params[:email])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 200, user: user }
    else
      render json: { status: 500, message: user.errors }
    end
  end

  def update
    if @user.update(params.permit(:profile_image, :name, :email))
      render json: { status: 200, user: @user }
    else
      render json: { status: 500, message: @user.errors }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

end
