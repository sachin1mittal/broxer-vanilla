module Workflows
  module UserWorkflow
    extend ActiveSupport::Concern
    included do
      include Workflow

      workflow_column :status
      workflow do

        state :verified do
          event :unverify, transitions_to: :unverified
        end

        state :unverified do
          event :verify, transitions_to: :verified
        end

        on_transition do |from, to, triggering_event, *event_args|
          user = self.class.current_user
          if user.present?
            self.action_logs.create!(user: user, action: triggering_event)
            self.touch_with_version
          end
        end
      end

      def verify
      end

      def unverify
      end
    end
  end
end
