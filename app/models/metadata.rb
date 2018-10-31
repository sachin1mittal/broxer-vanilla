class Metadata < ApplicationRecord
  self.table_name = 'metadatas'

  has_many :jobs_metadatas
  belongs_to :category
end
