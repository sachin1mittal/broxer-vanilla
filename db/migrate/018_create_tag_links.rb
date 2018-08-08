class CreateTagLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_links do |t|
      t.references :tag, index: true
      t.references :taggable, polymorphic: true, index: true
    end
  end
end
