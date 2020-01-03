#
# This module enable current user related methods on models
#
# @author [sachinmittal]
module Threadable
  extend ActiveSupport::Concern
  module ClassMethods
    #
    # Returns the instance user set in current thread
    #
    def current_user
      Thread.current[:user]
    end
  end
end
