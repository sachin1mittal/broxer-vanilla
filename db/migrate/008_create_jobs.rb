class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.references :category, index: true
      t.references :user, index: true
      t.string :title
      t.text :message_for_client
      t.text :description
      t.string :status, index: true
      t.jsonb :faqs
      t.string :admin_status
      t.integer :order_limit
      t.attachment :banner
      t.timestamps null: false
    end
  end
end
