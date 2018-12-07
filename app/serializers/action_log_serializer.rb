class ActionLogSerializer < ApplicationSerializer
  attributes :id, :actionable_type, :actionable_id, :action, :performer_id, 
             :created_at, :updated_at, :performer, :actionable
  
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :actionable_type, :actionable_id, :action, :performer_id, 
     :created_at, :updated_at]
  end
end