class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @conversations = current_user.active_conversations
  end
  
  def new  
    @conversation = Conversation.new
  end
  
  def create
    recipients = params[:conversation][:recipients].split(",")
    
    @conversation = Conversation.create_initial(:user => current_user, 
                                                :body => params[:conversation][:body],
                                                :recipients => recipients)
    
    if @conversation
      flash[:notice] = "Message created"
      redirect_to messages_path
    else
      flash[:error] = "Something went wrong"
      redirect_to new_conversation_path
    end
  end
  
end
