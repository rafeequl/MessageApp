class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.text :body
      t.references :conversation

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :conversation_id
  end
end
