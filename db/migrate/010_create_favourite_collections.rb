class CreateFavouriteCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :favourite_collections do |t|
      t.string :name
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
