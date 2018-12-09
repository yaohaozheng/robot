require 'net/https'
require 'uri'
require 'json'

class MessagesController < ApplicationController
  include SessionsHelper
  before_action :set_message, only: [:update, :destroy]

  def create
    #byebug
    @message = current_user.messages.build(message_params)
    chat=Chat.find_by_id(params[:chat_room])
    redirect_to chats_path, flash: {:warning => '此聊天不存在'} and return if chat.nil?
    @message.chat=chat
    #byebug
    if @message.save
      sync_new @message, scope: chat
      if chat.users[0].name=="robot"
        res=robot(@message.body)
        robot_params={"body" => res}
        @robot_message=chat.users[0].messages.build(robot_params)
        @robot_message.chat=chat
        @robot_message.save
        sync_new @robot_message, scope: chat
      end

    else
      redirect_to chat_path(chat), flash: {:warning => '消息发送失败'} and return
    end
    redirect_to chat_path(chat)
  end

  def destroy
    @message = Message.find(params[:id])
    chat=Chat.find_by_id(params[:chat_room])
    @message.destroy
    sync_destroy @message
    redirect_to chat_path(chat)
  end

  def destroyall
    chat=Chat.find_by_id(params[:chat_room])
    chat.messages.delete_all
    redirect_to chat_path(chat), flash: {info: '聊天记录已清空'}
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def robot(text)
    params = {}
    perception={}
    inputText={}
    userInfo={}
    inputText["text"]=text
    perception["inputText"]=inputText
    userInfo["apiKey"]="6d6a6357d00246f88cb176678898472d"
    userInfo["userId"]="360205"
    params["reqType"]=0
    params["perception"]=perception
    params["userInfo"]=userInfo
    #puts params.to_json

    base_path="http://openapi.tuling123.com/openapi/api/v2"
    uri = URI.parse("#{base_path}")
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    req.body = params.to_json

    res = Net::HTTP.new(uri.host, uri.port).start{|http|
      http.request(req)
    }
  
    resbody = JSON.parse(res.body)
  
    return resbody["results"][0]["values"]["text"]
  end


end

# def update
#   respond_to do |format|
#     if @message.update(message_params)
#       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
#       format.json { render :show, status: :ok, location: @message }
#     else
#       format.html { render :edit }
#       format.json { render json: @message.errors, status: :unprocessable_entity }
#     end
#   end
# end
