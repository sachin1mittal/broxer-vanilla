class CreateSpamReports < ActiveRecord::Migration[5.1]
  def change
    create_table :spam_reports do |t|
      t.references :reportable, polymorphic: true, index: true
      t.integer :reporter_id, index: true
      t.string :status, index: true
      t.string :comment
      t.timestamps null: false
    end
  end
end
