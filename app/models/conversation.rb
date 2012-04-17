class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  has_many :participations
  
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
    participation.conversation = conversation
    participation.save
    
    # tell other recipients
    recipients = params[:recipients]
    puts "=========> #{recipients.size}"
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
