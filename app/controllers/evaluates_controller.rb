class EvaluatesController < ApplicationController
  def show
    @evaluate = Evaluate.find(params[:id])
  end

  def new
    @evaluate = Evaluate.new
  end

  def create
    chat_id = params[:evaluate][:chat_id]
    @chat = Chat.find(chat_id)
    @evaluate = Evaluate.new(evaluate_params)
    if @evaluate.save
      redirect_to '/chats/'+chat_id.to_s
    else
      redirect_to '/chats/'+chat_id.to_s
    end
  end
private
  def evaluate_params
    params.require(:evaluate).permit(:user_id, :score)
  end

  @evaluate = Evaluate.new

end
