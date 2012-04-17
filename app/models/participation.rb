class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  # attr_accessible :title, :body
  
  scope :active, where(:active => true)
  
  def activate!
    self.update_attribute(:active, true)
  end
  
  def deactivate!
    self.update_attribute(:active, false)
  end
end
