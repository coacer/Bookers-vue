class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.string :content
      t.integer :from_id
      t.integer :to_id
      t.string :room_id

      t.timestamps
    end
  end
end
