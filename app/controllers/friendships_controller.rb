class FriendshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

  def create
    #byebug
    @friendship = current_user.friendships.build(:friend_id => params[:format])
    if @friendship.save
      #flash[:info] = params[:friend_id]
      flash[:info] = "添加好友成功"
      user=User.find_by_id(params[:format])
      @inverse_prefriendship=user.prefriendships.find_by(prefriend_id:current_user.id)
    
      if @inverse_prefriendship!=nil
        @inverse_prefriendship.destroy
      end
      
      redirect_to chats_path
    else
      flash[:error] = "无法添加好友"
      redirect_to chats_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy

    user=User.find_by_id(params[:id])
    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        chat.destroy
      end
    end

    flash[:success] = "删除好友成功"
    redirect_to chats_path
  end

  private
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

end
