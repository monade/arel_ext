# frozen_string_literal: true

# require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ArelExtensions::CommonSqlFunctions.new(ActiveRecord::Base.connection).add_sql_functions()

class User < ActiveRecord::Base
  has_many :posts
  has_one :primary_post, class_name: 'Post', foreign_key: 'user_id'
  validates :email, presence: true
end

class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
end

module Schema
  def self.create
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do
      create_table :users, force: true do |t|
        t.string 'email', null: false
        t.string 'name'
        t.timestamps null: false
      end

      create_table :posts, force: true do |t|
        t.belongs_to :user, index: true
        t.string 'title', null: false
        t.text 'body'
        t.timestamps null: false
      end
    end
  end
end
