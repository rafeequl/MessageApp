class AddActiveToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :active, :boolean, :default => true
  end
end
