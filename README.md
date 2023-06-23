![Tests](https://github.com/monade/arel_ext/actions/workflows/test.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/arel_ext.svg)](https://badge.fury.io/rb/arel_ext)

# arel_ext

A set of extensions to ActiveRecord Arel.

## Installation

Add the gem to your Gemfile

```ruby
  gem 'arel_ext'
```

Add an initializer for the configuration:

```ruby
ArelExt.install
```

And it's ready!

## Usage

### Simple SQL Functions invocation
You can easily invocate custom SQL functions, like string_agg:

```ruby
ArelExt::Func.string_agg(Arel::Table.new('posts')[:title], ',') # => string_agg("posts"."title", ',')
```

Equivalent to, in pure Arel:
```ruby
args = [Arel::Table.new('posts')[:title], Arel::Nodes.build_quoted(',')]
Arel::Nodes::NamedFunction.new('string_agg', args)
```

### Simplified arel_table access
You can access to arel_table columns through #[] directly from the label.

For instance:
```ruby
(User[:id] == 1).to_sql # "users"."id" = 1
```

Equivalent to:
```ruby
User.arel_table[:id].eq(1).to_sql
```

### Easy join using arel based on associations

```ruby
class User
  belongs_to :posts
end

User.arel_join(:posts).to_sql # => 'INNER JOIN "posts" ON "posts"."user_id" = "users"."id"'

User.join(User.arel_join(:posts)) # => It works!
```

You can also alias the table name:
```ruby
User.arel_join(:posts, as: 'my_posts').to_sql # => INNER JOIN "posts" "my_posts" ON "my_posts"."user_id" = "users"."id"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

About Monade
----------------

![monade](https://monade.io/wp-content/uploads/2021/06/monadelogo.png)

arel_ext is maintained by [mònade srl](https://monade.io/en/home-en/).

We <3 open source software. [Contact us](https://monade.io/en/contact-us/) for your next project!
