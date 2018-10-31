class CreateActionLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :action_logs do |t|
      t.belongs_to :actionable, polymorphic: true, index: true
      t.string :action
      t.integer :performer_id, index: true
      t.timestamps null: false
    end
  end
end
