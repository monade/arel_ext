# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ArelExt::Func do
  describe '#execute' do
    it 'invokes native sql functions with no parameters' do
      function = ArelExt::Func.execute('NOW')
      expect(function.to_sql).to eq 'NOW()'
    end

    it 'handles non-arel params' do
      function = ArelExt::Func.execute('some_function', 'foo', nil, 5, true, :symbol, 1.5)
      expect(function.to_sql).to eq 'some_function(\'foo\', NULL, 5, 1, \'symbol\', 1.5)'
    end

    it 'handles columns from arel' do
      function = ArelExt::Func.execute('string_agg', Arel::Table.new('posts')[:title], 'bar')
      expect(function.to_sql).to eq 'string_agg("posts"."title", \'bar\')'
    end
  end

  describe 'with reflection' do
    it 'passes methods to #execute' do
      expect(ArelExt::Func).to receive(:execute).with('string_agg', 'foo', 'bar')
      ArelExt::Func.string_agg('foo', 'bar')
    end

    it 'generates valid SQL code' do
      function = ArelExt::Func.string_agg('foo', 'bar')
      expect(function.to_sql).to eq 'string_agg(\'foo\', \'bar\')'
    end
  end
end
