# frozen_string_literal: true

require 'active_support'
require 'active_record'
require 'arel_extensions'

# ArelExt root module
module ArelExt
  extend ActiveSupport::Autoload
  autoload :ActiveRecord
  autoload :Association
  autoload :Func

  def self.install
    ::ActiveRecord::Base.send(:include, ArelExt::ActiveRecord)
    ::ActiveRecord::Reflection::AssociationReflection.send(:include, ArelExt::Association)
  end
end
