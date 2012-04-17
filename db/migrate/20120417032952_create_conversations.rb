class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user

      t.timestamps
    end
    add_index :conversations, :user_id
  end
end
