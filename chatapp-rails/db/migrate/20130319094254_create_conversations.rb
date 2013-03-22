class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.boolean :user_active

      t.timestamps
    end
  end
end
