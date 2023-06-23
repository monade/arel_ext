require 'active_support'
require 'rspec'
require 'active_record'
require 'arel_ext'

I18n.enforce_available_locales = false
RSpec::Expectations.configuration.warn_about_potential_false_positives = false

ArelExt.install

Dir[File.expand_path('support/*.rb', __dir__)].sort.each { |f| require f }

RSpec.configure do |config|
  # config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    Schema.create
  end

  config.around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
