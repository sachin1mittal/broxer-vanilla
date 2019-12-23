module Workflows
  module OrderDisputeStatusWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :dispute_status
      workflow do

        state :resolved do
          event :missing_details, transitions_to: :missing_details
          event :dispute, transitions_to: :disputed
        end

        state :missing_details do
          event :dispute, transitions_to: :disputed
          event :resolve, transitions_to: :resolved
        end

        state :disputed do
          event :resolve, transitions_to: :resolved
        end

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.touch_with_version
          end
        end
      end

      def resolve
      end

      def dispute
      end

      def missing_details
      end
    end
  end
end
