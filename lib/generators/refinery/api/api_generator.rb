module Refinery
  class ApiGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_api_initializer
      template 'config/initializers/refinery/api.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'api.rb')
    end
  end
end