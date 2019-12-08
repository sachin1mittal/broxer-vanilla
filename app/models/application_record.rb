class ApplicationRecord < ActiveRecord::Base
  #
  # Structure of the model should be like this.
  # == Extensions ===========================================================
  # == Constants ============================================================
  # == Attributes ===========================================================
  # == Associations =========================================================
  # == Validations ==========================================================
  # == Scopes ===============================================================
  # == Callbacks ============================================================
  # == Custom Validations ===================================================
  # == Class Methods ========================================================
  # == Instance Methods =====================================================
  #
  self.abstract_class = true

  include ActionView::Helpers::SanitizeHelper
  include Threadable
  include Filterable
  include Searchable
  include Sortable
  include Bufferable

  before_validation :sanitize_strings

  def self.scoped
    self.current_scope || self
  end

  #
  # Function to sanitize the String fields
  #
  def sanitize_strings
    self.attributes.each do |column, value|
      next unless value.is_a? String
      self[column] = strip_tags(value)
    end
  end
end
