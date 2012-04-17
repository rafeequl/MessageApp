class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :user
      t.references :conversation

      t.timestamps
    end
    add_index :participations, :user_id
    add_index :participations, :conversation_id
  end
end
