# frozen_string_literal: true

module ArelExt
  # Extension methods for ActiveRecord::Reflection::AssociationReflection
  module Association
    def arel_join(as: nil, left: false)
      join_table = klass.arel_table
      join_table = join_table.alias(as) if as
      table = active_record.arel_table

      active_record.arel_table.join(join_table, left ? Arel::Nodes::OuterJoin : Arel::Nodes::InnerJoin).on(
        _build_arel_join_condition(table, join_table)
      ).join_sources.first
    end

    private

    def _build_arel_join_condition(table, join_table)
      join_table[join_primary_key].eq(table[join_foreign_key])
    end
  end
end
