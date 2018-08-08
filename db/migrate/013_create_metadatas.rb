class CreateMetadatas < ActiveRecord::Migration[5.1]
  def change
    create_table :metadatas do |t|
      t.references :category, index: true
      t.string :context
      t.string :question
      t.string :allowed_values, array: true
      t.integer :allowed_values_count
    end
  end
end
