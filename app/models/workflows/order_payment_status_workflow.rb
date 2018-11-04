module Workflows
  module OrderPaymentStatusWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :payment_status
      workflow do

        state :unpaid do
          event :pay, transitions_to: :paid
        end

        state :paid do
          event :request_refund, transitions_to: :refund_requested
        end

        state :refund_requested do
          event :reject_refund, transitions_to: :paid
          event :refund, transitions_to: :refunded
        end

        state :refunded

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def pay
      end

      def request_refund
      end

      def reject_refund
      end

      def refund
      end
    end
  end
end
