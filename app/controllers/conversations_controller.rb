class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @conversations = current_user.active_conversations
  end
  
  def show
    @conversation = current_user.active_conversations.find_by_id(params[:id])
    @messages = @conversation.messages.order('created_at ASC')
    @message = @conversation.messages.build
  end
  
  def new  
    @conversation = Conversation.new
  end
  
  def create
    recipients = params[:conversation][:recipients].gsub(/\s/, '').split(",")
    
    @conversation = Conversation.create_initial(:user => current_user, 
                                                :body => params[:conversation][:body],
                                                :recipients => recipients)
    
    if @conversation
      flash[:notice] = "Message created"
      redirect_to conversations_path
    else
      flash[:error] = "Something went wrong"
      redirect_to new_conversation_path
    end
  end
  
  def reply
    participation = Participation.find_by_user_id_and_conversation_id(current_user.id, params[:message][:conversation_id])
    @message = current_user.messages.build(:body => params[:message][:body])
    @message.conversation_id = params[:message][:conversation_id]
    
    if @message.save
      # activate conversation if its 2 way communication
      participations = Participation.where(:conversation_id => params[:message][:conversation_id])
      if participations.count == 2
        participations.each do |p|
          p.activate! unless p.active?
        end
      end
        
      
      flash[:notice] = "Message sent!"
      redirect_to :back
    else
      flash[:error] = "Oops something went wrong"
      redirect_to :back
    end
  end
  
  def destroy
    @participation = current_user.participations.find_by_conversation_id(params[:id])
    
    if @participation.deactivate!
      flash[:notice] = 'Conversation archived!'
      redirect_to conversations_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to conversations_path
    end
    
  end
end
