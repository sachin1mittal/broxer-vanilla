class CreateJobsMetadatas < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs_metadatas do |t|
      t.references :job, index: true
      t.references :metadata, index: true
      t.string :values, array: true
      t.index [:values], using: :gin
      t.timestamps null: false
    end
  end
end
