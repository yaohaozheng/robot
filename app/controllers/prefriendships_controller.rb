class PrefriendshipsController < ApplicationController

    include SessionsHelper
    before_action :logged_in
  
    def create
      @prefriendship = current_user.prefriendships.build(:prefriend_id => params[:prefriend_id])
      if @prefriendship.save
        flash[:info] = "发送请求成功"
        redirect_to chats_path
      else
        flash[:error] = "无法添加好友"
        redirect_to chats_path
      end
    end
  
    def destroy
      #byebug
      @prefriendship = current_user.prefriendships.find_by(prefriend_id: params[:id])
      if @prefriendship!=nil
        @prefriendship.destroy
        flash[:success] = "撤销请求成功"
      end
      #byebug
      user=User.find_by_id(params[:id])
      @inverse_prefriendship=user.prefriendships.find_by(prefriend_id:current_user.id)
      #@inverse_prefriendship = current_user.inverse_prefriendships.find_by(prefriend_id: params[:id])本来想通过反向朋友关系直接删除，但实际上不行，所以就直接找到发送请求的user，正向删除。
      if @inverse_prefriendship!=nil
        @inverse_prefriendship.destroy
        flash[:success] = "拒绝成功"
      end
      redirect_to chats_path
    end
  
    private
    def logged_in
      unless logged_in?
        redirect_to root_url, flash: {danger: '请登陆'}
      end
    end
  
  end