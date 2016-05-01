require 'rails/generators'
require 'rails/generators/base'

module Refinery
  class ApiGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def rake_db
      rake "refinery_api:install:migrations"
    end

    def generate_api_initializer
      template 'config/initializers/refinery/api.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'api.rb')
    end
  end
end