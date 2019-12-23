class CreateBenefits < ActiveRecord::Migration[5.1]
  def change
    create_table :benefits do |t|
      t.references :category, index: true
      t.string :name
      t.string :allowed_values, array: true
      t.integer :allowed_values_count
    end
  end
end
