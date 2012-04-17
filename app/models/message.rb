class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  attr_accessible :body
  
  validates_presence_of :user_id, :conversation_id, :body
end
