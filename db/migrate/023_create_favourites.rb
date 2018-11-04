class CreateFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.integer :collection_id, index: true
      t.references :favourable, polymorphic: true, index: { name: 'index_f_collections_on_f_type_and_f_id' }
      t.string :status, index: true
      t.timestamps null: false
    end
  end
end
