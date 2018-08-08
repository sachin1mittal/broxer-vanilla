class JobsMetadata < ApplicationRecord
  self.table_name = 'jobs_metadatas'
  has_paper_trail

  belongs_to :job
  belongs_to :metadata

  validates :values, presence: true
end
