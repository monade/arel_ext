# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe User, type: :model do
  # rubocop:enable Metrics/BlockLength
  context 'with columns' do
    subject { User[:id] }
    it { is_expected.to eq Arel::Table.new('users')[:id] }
    it { is_expected.to eq User.arel_table[:id] }
  end

  context 'with associations' do
    it 'resolves a has_many association' do
      join = User.reflect_on_association(:posts).arel_join

      expect(join).to be_a Arel::Nodes::Join
      expect(join.to_sql).to eq('INNER JOIN "posts" ON "posts"."user_id" = "users"."id"')

      expect(User.joins(join).to_sql).to eq('SELECT "users".* FROM "users" INNER JOIN "posts" ON "posts"."user_id" = "users"."id"')
    end

    it 'resolves a belongs_to association' do
      join = Post.reflect_on_association(:user).arel_join

      expect(join).to be_a Arel::Nodes::Join
      expect(join.to_sql).to eq('INNER JOIN "users" ON "users"."id" = "posts"."user_id"')

      expect(User.joins(join).to_sql).to eq('SELECT "users".* FROM "users" INNER JOIN "users" ON "users"."id" = "posts"."user_id"')
    end

    it 'resolves a has_one association' do
      join = User.reflect_on_association(:primary_post).arel_join

      expect(join).to be_a Arel::Nodes::Join
      expect(join.to_sql).to eq('INNER JOIN "posts" ON "posts"."user_id" = "users"."id"')

      expect(User.joins(join).to_sql).to eq('SELECT "users".* FROM "users" INNER JOIN "posts" ON "posts"."user_id" = "users"."id"')
    end

    it 'runs left outer join' do
      join = User.reflect_on_association(:posts).arel_join(left: true)

      expect(join.to_sql).to eq('LEFT OUTER JOIN "posts" ON "posts"."user_id" = "users"."id"')
    end

    it 'can be aliased' do
      join = User.reflect_on_association(:posts).arel_join(as: 'happy_posts')

      expect(join.to_sql).to eq('INNER JOIN "posts" "happy_posts" ON "happy_posts"."user_id" = "users"."id"')
    end

    it 'can be used with the short syntax' do
      join = User.arel_join(:posts, as: 'happy_posts')

      expect(join.to_sql).to eq('INNER JOIN "posts" "happy_posts" ON "happy_posts"."user_id" = "users"."id"')
    end
  end
end
