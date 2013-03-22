class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.integer :creator_id

      t.timestamps
    end
  end
end
