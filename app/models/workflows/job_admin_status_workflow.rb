module Workflows
  module JobAdminStatusWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :status
      workflow do

        state :approved do
          event :disapprove, transitions_to: :disapproved
        end

        state :disapproved do
          event :approve, transitions_to: :approved
        end

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def approve
      end

      def disapprove
      end
      
    end
  end
end
