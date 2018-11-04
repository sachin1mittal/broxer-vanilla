class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.belongs_to :contentable, polymorphic: true
      t.integer :sender_id, index: true
      t.integer :recipient_id, index: true
      t.string :message_display_id # to be use on fronend
      t.string :status
      t.string :channel
      t.timestamps
    end
    add_index :messages, [:sender_id, :recipient_id]
  end
end
