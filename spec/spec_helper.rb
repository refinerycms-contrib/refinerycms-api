require 'rubygems'

# Configure Rails Environment
ENV["RAILS_ENV"] ||= 'test'


if ENV["COVERAGE"]
  # Run Coverage report
  require 'simplecov'
  SimpleCov.start do
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Views', 'app/views'
    add_group 'Libraries', 'lib'
  end
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

begin
  require File.expand_path("../dummy/config/environment", __FILE__)
rescue LoadError
  puts "Could not load dummy application. Please ensure you have run `bundle exec rake test_app`"
  exit
end

require 'rspec/rails'
# require 'ffaker'
require 'capybara/rspec'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

# require 'refinery/testing_support/factories'
# require 'refinery/testing_support/preferences'

require 'refinery/api/testing_support/caching'
require 'refinery/api/testing_support/helpers'
require 'refinery/api/testing_support/setup'
# require 'refinery/testing_support/shoulda_matcher_configuration'

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.backtrace_exclusion_patterns = %w(
    rails actionpack railties capybara activesupport rack warden rspec actionview
    activerecord dragonfly benchmark
  ).map { |noisy| /#{noisy}/ }
  config.color = true
  config.fail_fast = ENV['FAIL_FAST'] || false
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.use_transactional_fixtures = true

  config.include FactoryGirl::Syntax::Methods
  config.include Refinery::Api::TestingSupport::Helpers, :type => :controller
  config.extend Refinery::Api::TestingSupport::Setup, :type => :controller
  # config.include Refinery::TestingSupport::Preferences, :type => :controller

  config.before do
    Refinery::Api.requires_authentication = true
  end
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories including factories.
([Rails.root.to_s] | ::Refinery::Plugins.registered.pathnames).map{|p|
  Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
}.flatten.sort.each do |support_file|
  require support_file
end
