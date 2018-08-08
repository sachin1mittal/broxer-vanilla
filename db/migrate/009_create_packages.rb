class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.references :job, index: true
      t.string :title
      t.string :package_type
      t.text :description
      t.integer :delivery_time
      t.integer :revisions
      t.integer :price
      t.jsonb :extras

      t.timestamps null: false
    end
  end
end
