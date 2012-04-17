class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :messages
  has_many :conversations
  has_many :participations
  
  def active_conversations
    participations = self.participations.active.select('distinct participations.conversation_id, participations.conversation_id')
    conversation_ids = participations.map { |p| p.conversation_id }
    
    if conversation_ids.blank?
      return []
    else
      return Conversation.where(:id => conversation_ids)
    end
    
  end
  
end
