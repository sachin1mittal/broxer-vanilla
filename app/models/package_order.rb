class PackageOrder < Order

  belongs_to :package

  validates_presence_of :quantity, :amount
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
