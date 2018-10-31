class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.integer :parent_id, index: true
      t.string :name
      t.text :description
      t.attachment :banner
      t.attachment :logo
    end
  end
end
