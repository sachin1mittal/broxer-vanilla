class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.references :documentable, polymorphic: true, index: true
      t.attachment :fyle
      t.timestamps null: false
    end
  end
end
