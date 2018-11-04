class CreatePackagesBenefits < ActiveRecord::Migration[5.1]
  def change
    create_table :packages_benefits do |t|
      t.references :benefit, index: true
      t.references :package, index: true
      t.string :values, array: true
      t.index [:values], using: :gin

      t.timestamps null: false
    end
  end
end
