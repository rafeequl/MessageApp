class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = current_user.active_conversations
  end
  
  def new
    
  end
  
  def create
    
  end
  
end
