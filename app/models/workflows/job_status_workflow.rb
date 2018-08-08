module Workflows
  module JobStatusWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :status
      workflow do

        state :draft do
          event :post, transitions_to: :posted
        end

        state :posted do
          event :inactive, transitions_to: :inactive
        end

        state :inactive do
          event :post, transitions_to: :posted
        end

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def inactive
      end

      def post
      end
    end
  end
end
