class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Threadable
  include Filterable
  include Searchable
  include Sortable
  include CustomTimestamps
  include Bufferable

  def self.scoped
    self.current_scope || self
  end

  def self.default_attributes
    not_implemented
  end
end
