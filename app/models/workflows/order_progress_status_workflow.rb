module Workflows
  module OrderProgressStatusWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :progress_status
      workflow do

        state :active do
          event :cancel, transitions_to: :cancelled
          event :deliver, transitions_to: :delivered
        end

        state :delivered do
          event :revise, transitions_to: :revision
          event :cancel, transitions_to: :cancelled
          event :complete, transitions_to: :completed
        end

        state :revision do
          event :cancel, transitions_to: :cancelled
          event :complete, transitions_to: :completed
        end

        state :cancelled
        state :completed

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def cancel
      end

      def complete
      end

      def deliver
      end

      def revise
      end
    end
  end
end
