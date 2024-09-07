class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    follow = Relationship.new(follower_id: current_user.id, followed_id: user.id)
    follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:user_id])
    follow = Relationship.find_by(follower_id: current_user.id, followed_id: user.id)
    follow.destroy
    redirect_back(fallback_location: root_path)
  end

  def followings
    @user = User.find(params[:user_id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers
  end
end