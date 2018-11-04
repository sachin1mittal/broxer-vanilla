class Role < ApplicationRecord
  validates_presence_of :label

  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  def self.default_role
    buyer_role
  end

  def self.buyer
    self.find_or_create_by!(label: 'buyer')
  end

  def self.admin
    self.find_or_create_by!(label: 'admin')
  end

  def self.seller
    self.find_or_create_by!(label: 'seller')
  end

  def self.manager
    self.find_or_create_by!(label: 'manager')
  end

  #
  # Add given permission to role
  # @param permission [Permission] Permission
  #
  def add_permission(permission)
    return if self.permissions.exists?(permission.id)
    self.permissions << permission
  end
end
