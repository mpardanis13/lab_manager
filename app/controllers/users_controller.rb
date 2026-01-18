class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Παίρνουμε όλους τους χρήστες εκτός από τον εαυτό μας
    @users = User.where.not(id: current_user.id)
  end

  def add_friend
    @friend = User.find(params[:id])
    current_user.friends << @friend unless current_user.friends.include?(@friend)
    redirect_to users_path, notice: "Η επαφή προστέθηκε!"
  end
end