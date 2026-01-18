class UsersController < ApplicationController
  before_action :authorize_request, if: -> { request.format.json? }
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def add_friend
    @friend = User.find(params[:id])
    
    unless current_user.friends.include?(@friend)
      # Αμφίδρομη προσθήκη
      current_user.friends << @friend
      @friend.friends << current_user
      redirect_to users_path, notice: "Η επαφή προστέθηκε αμφίδρομα!"
    else
      redirect_to users_path, alert: "Είναι ήδη στις επαφές σας."
    end
  end

  def remove_friend
    @friend = User.find(params[:id])
    
    # Διαγραφή της δικής μου σχέσης με αυτόν
    current_user.friendships.find_by(friend_id: @friend.id)&.destroy
    # Διαγραφή της δικής του σχέσης με εμένα
    @friend.friendships.find_by(friend_id: current_user.id)&.destroy
    
    redirect_to users_path, notice: "Η επαφή αφαιρέθηκε."
  end
end