module Queries::CustomFilters
  class ActionLog < ::Queries::Filters
    FILTERS_PRIORITY = {
      performed_action: 0,
      created_from: 1,
      created_to: 1
    }

    #
    # Filter action logs by date created
    # @param date [String]
    #
    def created_from(date)
      scope.where('action_logs.created_at >= ?', date.to_date.beginning_of_day)
    end

    #
    # Filter action logs by date created
    # @param date [String]
    #
    def created_to(date)
      scope.where('action_logs.created_at <= ?', date.to_date.end_of_day)
    end

    #
    # Filter action logs by performed_action
    # @param date [String]
    #
    def performed_action(performed_action)
      scope.where(action: performed_action)
    end

  end
end
