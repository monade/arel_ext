# frozen_string_literal: true

namespace :gem do
  task :release do
    desc 'Releases the gem'
    filename = `gem build arel_ext.gemspec 2> /dev/null | grep -E 'File:'`.split(' ').last
    `gem push #{filename}`
  end
end
