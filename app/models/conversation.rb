class Conversation < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :recipients, :body
    
  def self.create_initial(params)
    # create conversation
    sender = params[:user]
    conversation = sender.conversations.build
    conversation.save
    
    # build message
    message = sender.messages.build(:body => params[:body])
    message.conversation = conversation
    message.save
    
    # create sender participation
    participation = sender.participations.build
    participation.save
    
    # tell other recipients
    recipients = params[:recipients]
    recipients.each do |r|
      recipient = User.find_by_email(r)
      if recipient
        participation = recipient.participations.build
        participation.conversation = conversation
        participation.save
      end
    end
  end
  
end
