# frozen_string_literal: true

module ArelExt
  # Extension methods for ActiveRecord::Base
  module ActiveRecord
    extend ActiveSupport::Concern

    # @private
    module ClassMethods
      def [](value)
        arel_table[value]
      end

      def arel_join(association_name, as: nil, left: false)
        association = reflect_on_association(association_name)
        association.arel_join(as: as, left: left)
      end
    end
  end
end
