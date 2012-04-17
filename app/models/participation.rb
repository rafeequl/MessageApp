class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  # attr_accessible :title, :body
end
