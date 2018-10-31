module Workflows
  module PaymentTransactionWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :status
      workflow do

        state :pending do
          event :success, transitions_to: :success
          event :failure, transitions_to: :failure
        end

        state :success, :failure

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def success
      end

      def failure
      end
    end
  end
end
