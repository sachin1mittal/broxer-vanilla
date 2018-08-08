class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true, index: true
      t.integer :reviewer_id, index: true
      t.string :act
      t.string :comment
      t.integer :parent_id, index: true
      t.decimal :rating, precision: 2, scale: 1
      t.timestamps null: false
    end
  end
end
