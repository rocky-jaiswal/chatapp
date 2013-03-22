class ModifyChatrooms < ActiveRecord::Migration
  def change
    add_column :chat_rooms, :channel, :string
  end
end