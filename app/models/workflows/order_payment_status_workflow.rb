module Workflows
  module OrderPaymentStatusWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :status
      workflow do

        state :pending do
          event :place, transitions_to: :placed
        end

        state :placed do
          event :start, transitions_to: :in_progress
          event :reject, transitions_to: :rejected
        end

        state :in_progress do
          event :reject, transitions_to: :rejected
          event :submit, transitions_to: :submitted
        end

        state :submitted do
          event :reject_submission, transitions_to: :submission_rejected
          event :deliver, transitions_to: :delivered
        end

        state :submission_rejected do
          event :submit, transitions_to: :submitted
          event :reject, transitions_to: :rejected
        end

        state :delivered

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def place
      end

      def start
      end

      def reject
      end

      def submit
      end

      def reject_submission
      end

      def deliver
      end
    end
  end
end
