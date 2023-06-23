# frozen_string_literal: true

module ArelExt
  # A helper class to build Arel::Nodes::NamedFunction
  # @example
  #   ArelExt::Func.execute('NOW')
  #   ArelExt::Func.string_agg('foo', 'bar')
  class Func
    class << self
      # @param [String] name
      # @param [Array] args
      # @return [Arel::Nodes::NamedFunction]
      def execute(name, *args)
        Arel::Nodes::NamedFunction.new(name, prepare_args(args))
      end

      def method_missing(method_name, *arguments, &block)
        execute(method_name.to_s, *arguments, &block)
      end

      def respond_to_missing?(_method_name, _include_private = false)
        true
      end

      private

      # @param [Array]
      # @return [Array]
      def prepare_args(args)
        args.map do |arg|
          case arg
          when String, Symbol, Numeric, TrueClass, FalseClass, NilClass
            Arel::Nodes.build_quoted(arg)
          else
            arg
          end
        end
      end
    end
  end
end
