class User::MessagesController < User::BaseController

  def index
    @received_messages = Message.lasts_messages(current_user)
    if params[:user_sender_id]
      @user_sender = User.find(params[:user_sender_id])
    elsif !@received_messages.first.nil?
      @user_sender = @received_messages.first.sender 
    end
    load_conversation
    render layout:"user/plan_layout"
  end

  def show
    @user_sender = User.find(params[:user_sender_id])
    load_conversation
  end

  def new
    @message = Message.new(user_receiver_id:params[:user_receiver_id])
    render layout:false
  end

  def create
    @message = Message.new(message_params)
    @message.user_sender_id = current_user.id
    @message.save
  end
 
  private
    def load_conversation
      return if @user_sender.nil?
      @messages = Message.all_by_user(current_user.id,@user_sender.id)
    end

    def message_params
      params.require(:message).permit(:content,:user_receiver_id)
    end
end
